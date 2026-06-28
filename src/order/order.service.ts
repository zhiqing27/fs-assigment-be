import {
  Injectable,
  BadRequestException,
} from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Order, OrderStatus } from '../entities/order.entity';
import { OrderItem } from '../entities/order-item.entity';
import { ProductColor } from '../entities/product-color.entity';
import { CreateOrderDto } from './dtos/create-order.dto';
import { FindOrdersQueryDto } from './dtos/find-orders-query.dto';

@Injectable()
export class OrderService {
  private orderRepository: Repository<Order>;

  constructor(private dataSource: DataSource) {
    this.orderRepository = this.dataSource.getRepository(Order);
  }

  async create(dto: CreateOrderDto): Promise<Order> {
    return await this.dataSource.transaction(async (entityManager) => {
      const pc = await entityManager.findOneByOrFail(ProductColor, {
        id: dto.productColorId,
      });

      const orderNumber = `ORD-${Date.now()}-${Math.random().toString(36).slice(2, 6).toUpperCase()}`;

      const order = entityManager.create(Order, {
        orderNumber,
        clientId: dto.clientId,
        status: OrderStatus.PENDING,
        totalAmount: Number(pc.price),
        totalItems: 1,
        items: [
          entityManager.create(OrderItem, {
            productId: pc.productId,
            productColorId: pc.id,
          }),
        ],
      });

      return await entityManager.save(Order, order);
    });
  }

  async findAll(clientId: string, query: FindOrdersQueryDto) {
    const { limit, offset } = query;

    const [orders, total] = await this.orderRepository
      .createQueryBuilder('order')
      .leftJoinAndSelect('order.items', 'item')
      .leftJoinAndSelect('item.product', 'product')
      .leftJoinAndSelect('item.productColor', 'pc')
      .leftJoinAndSelect('pc.color', 'color')
      .where('order.clientId = :clientId', { clientId })
      .orderBy('order.createdAt', 'ASC')
      .skip(offset)
      .take(limit)
      .getManyAndCount();

    const data = orders.map((order) => {
      const item = order.items[0];
      return {
        id: order.id,
        orderId: order.orderNumber,
        productId: item?.productId ?? '',
        productName: item?.product?.name ?? '',
        productColor: item?.productColor?.color?.name ?? '',
        currentStock: item?.productColor?.stock ?? 0,
        status: order.status,
        createdAt: order.createdAt,
      };
    });

    return { data, total, limit, offset, totalPages: Math.ceil(total / limit) };
  }

  async complete(id: string): Promise<boolean> {
    return await this.dataSource.transaction(async (entityManager) => {
      const order = await entityManager
        .createQueryBuilder(Order, 'order')
        .where('order.id = :id', { id })
        .andWhere('order.status = :status', { status: OrderStatus.PENDING })
        .setLock('pessimistic_write')
        .getOneOrFail();

      const item = await entityManager.findOneOrFail(OrderItem, {
        where: { orderId: order.id },
      });

      const pc = await entityManager
        .createQueryBuilder(ProductColor, 'pc')
        .where('pc.id = :id', { id: item.productColorId })
        .setLock('pessimistic_write')
        .getOneOrFail();

      if (pc.stock < 1)
        throw new BadRequestException(`Insufficient stock`);

      pc.stock -= 1;
      await entityManager.save(ProductColor, pc);

      order.status = OrderStatus.COMPLETED;
      await entityManager.save(Order, order);
      return true;
    });
  }
}
