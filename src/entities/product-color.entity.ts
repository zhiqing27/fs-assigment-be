import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  CreateDateColumn,
  UpdateDateColumn,
  JoinColumn,
  Index,
  Unique,
} from 'typeorm';
import { Product } from './product.entity';
import { Color } from './color.entity';

@Unique(['productId', 'colorId'])
@Index(['productId', 'colorId'])
@Entity('product_colors')
export class ProductColor {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ type: 'integer', default: 0 })
  stock!: number;

  @Column({ type: 'decimal', precision: 10, scale: 2, default: 0 })
  price!: number;

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;

  @ManyToOne(() => Product, (product) => product.colors, {
    onDelete: 'CASCADE',
    eager: false,
  })
  @JoinColumn({ name: 'productId' })
  product!: Product;

  @Column('uuid')
  productId!: string;

  @ManyToOne(() => Color, (color) => color.productColors, {
    eager: true,
    onDelete: 'RESTRICT',
  })
  @JoinColumn({ name: 'colorId' })
  color!: Color;

  @Column('uuid')
  colorId!: string;
}
