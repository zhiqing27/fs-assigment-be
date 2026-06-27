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

@Entity('order_items')
export class OrderItem {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ type: 'varchar', length: 100, nullable: true })
  selectedColor!: string;

  @Column({ type: 'varchar', length: 7, nullable: true })
  selectedColorCode!: string;

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
}
