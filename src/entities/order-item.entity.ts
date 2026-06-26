import {
    Entity,
    PrimaryGeneratedColumn,
    Column,
    ManyToOne,
    CreateDateColumn,
    UpdateDateColumn,
    JoinColumn,
  } from 'typeorm';
  import { Order } from './order.entity';
  import { Product } from './product.entity';
  
  @Entity('order_items')
  export class OrderItem {
    @PrimaryGeneratedColumn('uuid')
    id: string;
  
    @Column({ type: 'integer' })
    quantity: number;
  
    @Column({ type: 'decimal', precision: 10, scale: 2 })
    unitPrice: number;
  
    @Column({ type: 'decimal', precision: 10, scale: 2 })
    totalPrice: number;
  
    @Column({ type: 'varchar', length: 100, nullable: true })
    selectedColor: string;
  
    @Column({ type: 'varchar', length: 7, nullable: true })
    selectedColorCode: string;
  
    @CreateDateColumn()
    createdAt: Date;
  
    @UpdateDateColumn()
    updatedAt: Date;
  
    @ManyToOne(() => Order, (order) => order.items, {
      onDelete: 'CASCADE',
      eager: false,
    })
    @JoinColumn({ name: 'orderId' })
    order: Order;
  
    @Column('uuid')
    orderId: string;
  
    @ManyToOne(() => Product, (product) => product.orderItems, {
      eager: true,
    })
    @JoinColumn({ name: 'productId' })
    product: Product;
  
    @Column('uuid')
    productId: string;
  }