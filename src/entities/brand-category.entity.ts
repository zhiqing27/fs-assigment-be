import {
  Entity,
  PrimaryGeneratedColumn,
  ManyToOne,
  JoinColumn,
  Column,
  Index,
  CreateDateColumn,
} from 'typeorm';
import { Brand } from './brand.entity';
import { Category } from './category.entity';

@Entity('brand_categories')
export class BrandCategory {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @ManyToOne(() => Brand, { onDelete: 'CASCADE', eager: false })
  @JoinColumn({ name: 'brandId' })
  brand!: Brand;

  @Index()
  @Column('uuid')
  brandId!: string;

  @ManyToOne(() => Category, { onDelete: 'CASCADE', eager: false })
  @JoinColumn({ name: 'categoryId' })
  category!: Category;

  @Index()
  @Column('uuid')
  categoryId!: string;

  @CreateDateColumn()
  createdAt!: Date;
}
