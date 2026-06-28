import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  OneToMany,
  CreateDateColumn,
  UpdateDateColumn,
  JoinColumn,
  Index,
} from 'typeorm';
import { Brand } from './brand.entity';
import { Category } from './category.entity';
import { ProductColor } from './product-color.entity';
import { OrderItem } from './order-item.entity';

@Entity('products')
export class Product {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Index()
  @Column({ type: 'varchar', length: 255 })
  name!: string;

  @Column({ type: 'text', nullable: true })
  description!: string;

  @Column({ type: 'varchar', length: 255, nullable: true })
  imageUrl!: string;

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;

  @ManyToOne(() => Brand, (brand) => brand.products, {
    onDelete: 'CASCADE',
    eager: true,
  })
  @JoinColumn({ name: 'brandId' })
  brand!: Brand;

  @Index()
  @Column('uuid')
  brandId!: string;

  @ManyToOne(() => Category, (category) => category.products, {
    onDelete: 'RESTRICT',
    eager: true,
  })
  @JoinColumn({ name: 'categoryId' })
  category!: Category;

  @Index()
  @Column('uuid')
  categoryId!: string;

  @OneToMany(() => ProductColor, (color) => color.product, {
    cascade: true,
    eager: true,
  })
  colors!: ProductColor[];

  @OneToMany(() => OrderItem, (orderItem) => orderItem.product)
  orderItems!: OrderItem[];
}
