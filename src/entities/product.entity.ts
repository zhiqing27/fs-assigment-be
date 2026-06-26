import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  OneToMany,
  CreateDateColumn,
  UpdateDateColumn,
  JoinColumn,
} from 'typeorm';
import { Brand } from './brand.entity';
import { ProductColor } from './product-color.entity';
import { OrderItem } from './order-item.entity';
@Entity('products')
export class Product {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'varchar', length: 255 })
  name: string;

  @Column({ type: 'text', nullable: true })
  description: string;

  @Column({ type: 'varchar', length: 255, nullable: true })
  imageUrl: string;

  @Column({ type: 'decimal', precision: 10, scale: 2 })
  basePrice: number;

  @Column({ type: 'integer', default: 0 })
  totalStock: number;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @ManyToOne(() => Brand, (brand) => brand.products, {
    onDelete: 'CASCADE',
    eager: true,
  })
  @JoinColumn({ name: 'brandId' })
  brand: Brand;

  @Column('uuid')
  brandId: string;

  @OneToMany(() => ProductColor, (color) => color.product, {
    cascade: true,
    eager: true,
  })
  colors: ProductColor[];

  @OneToMany(() => OrderItem, (orderItem) => orderItem.product)
  orderItems: OrderItem[];
}
