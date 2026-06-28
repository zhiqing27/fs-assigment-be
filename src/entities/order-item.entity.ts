import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
  Index,
} from 'typeorm';
import { Order } from './order.entity';
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

  @ManyToOne(() => ProductColor, {
    eager: false,
    nullable: true,
    onDelete: 'RESTRICT',
  })
  @JoinColumn({ name: 'productColorId' })
  productColor!: ProductColor | null;

  @Index()
  @Column({ type: 'uuid', nullable: true })
  productColorId!: string | null;
}
