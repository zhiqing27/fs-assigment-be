import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';
import { Order, OrderStatus } from '../entities/order.entity';
import { OrderItem } from '../entities/order-item.entity';
import { Product } from '../entities/product.entity';
import { CreateOrderDto } from './dtos/create-order.dto';
import { FindOrdersResponseDto, OrderResponseDto } from './dtos/order-response.dto';

@Injectable()
export class OrdersService {
  constructor(@InjectDataSource() private ds: DataSource) {}

  async create(dto: CreateOrderDto): Promise<OrderResponseDto> {
    const product = await this.ds.getRepository(Product).findOne({
      where: { id: dto.productId },
      relations: ['colors'],
    });

    if (!product) throw new NotFoundException('Product not found');

    const color = dto.selectedColor
      ? product.colors.find((c) => c.name === dto.selectedColor)
      : product.colors[0];

    if (!color) throw new BadRequestException('Color not found for this product');

    const quantity = dto.quantity ?? 1;
    const price = Number(color.price) || Number(product.basePrice);
    const orderNumber = await this.generateOrderNumber();

    const order = this.ds.getRepository(Order).create({
      orderNumber,
      clientId: dto.clientId,
      status: OrderStatus.PENDING,
      totalAmount: price * quantity,
      totalItems: quantity,
    });

    const saved = await this.ds.getRepository(Order).save(order);

    const item = this.ds.getRepository(OrderItem).create({
      orderId: saved.id,
      productId: product.id,
      selectedColor: color.name,
      selectedColorCode: color.colorCode,
    });

    await this.ds.getRepository(OrderItem).save(item);

    return this.mapToResponse(saved, product.name, color.name);
  }

  async findByClientId(
    clientId: string,
    limit = 10,
    offset = 0,
  ): Promise<FindOrdersResponseDto> {
    const [orders, total] = await this.ds
      .getRepository(Order)
      .createQueryBuilder('o')
      .leftJoinAndSelect('o.items', 'i')
      .leftJoinAndSelect('i.product', 'p')
      .where('o.clientId = :clientId', { clientId })
      .orderBy('o.createdAt', 'DESC')
      .skip(offset)
      .take(limit)
      .getManyAndCount();

    const data = orders.map((order) => {
      const item = order.items?.[0];
      return this.mapToResponse(order, item?.product?.name ?? '', item?.selectedColor ?? '');
    });

    return { data, total, limit, offset, totalPages: Math.ceil(total / limit) };
  }

  async setCompleted(id: string): Promise<OrderResponseDto> {
    const order = await this.ds.getRepository(Order).findOne({
      where: { id },
      relations: ['items', 'items.product'],
    });

    if (!order) throw new NotFoundException('Order not found');

    order.status = OrderStatus.DELIVERED;
    order.deliveredAt = new Date();
    await this.ds.getRepository(Order).save(order);

    const item = order.items?.[0];
    return this.mapToResponse(order, item?.product?.name ?? '', item?.selectedColor ?? '');
  }

  private async generateOrderNumber(): Promise<string> {
    const count = await this.ds.getRepository(Order).count();
    return `MY${String(count + 1).padStart(6, '0')}`;
  }

  private mapToResponse(order: Order, productName: string, productColor: string): OrderResponseDto {
    return {
      orderId: order.orderNumber,
      orderNumber: order.orderNumber,
      productId: order.items?.[0]?.productId ?? '',
      productName,
      productColor,
      status: order.status === OrderStatus.DELIVERED ? 'Completed' : 'Open',
      createdAt: order.createdAt,
    };
  }
}
