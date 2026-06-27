import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
  Index,
} from 'typeorm';
import { Order } from './order.entity';
import { Product } from './product.entity';
import { ProductColor } from './product-color.entity';

@Entity('order_items')
export class OrderItem {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @ManyToOne(() => Order, (order) => order.items, {
    onDelete: 'CASCADE',
    eager: false,
  })
  @JoinColumn({ name: 'orderId' })
  order!: Order;

  @Index()
  @Column('uuid')
  orderId!: string;

  @ManyToOne(() => Product, (product) => product.orderItems, {
    eager: true,
  })
  @JoinColumn({ name: 'productId' })
  product!: Product;

  @Index()
  @Column('uuid')
  productId!: string;

  @ManyToOne(() => ProductColor, {
    eager: true,
    nullable: true,
    onDelete: 'RESTRICT',
  })
  @JoinColumn({ name: 'productColorId' })
  productColor!: ProductColor | null;

  @Index()
  @Column({ type: 'uuid', nullable: true })
  productColorId!: string | null;
}
