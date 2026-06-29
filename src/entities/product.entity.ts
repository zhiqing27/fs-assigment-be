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
import { BrandCategory } from './brand-category.entity';
import { ProductColor } from './product-color.entity';

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

  @ManyToOne(() => BrandCategory, { onDelete: 'RESTRICT', eager: false })
  @JoinColumn({ name: 'brandCategoryId' })
  brandCategory!: BrandCategory;

  @Index()
  @Column('uuid')
  brandCategoryId!: string;

  @OneToMany(() => ProductColor, (color) => color.product, {
    cascade: true,
    eager: true,
  })
  colors!: ProductColor[];

}
