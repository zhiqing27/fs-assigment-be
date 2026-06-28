import {
  Entity,
  PrimaryGeneratedColumn,
  ManyToOne,
  JoinColumn,
  Column,
  Index,
  CreateDateColumn,
  Unique,
} from 'typeorm';
import { Brand } from './brand.entity';
import { Category } from './category.entity';

@Unique(['brandId', 'categoryId'])
@Index(['brandId', 'categoryId'])
@Entity('brand_categories')
export class BrandCategory {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @ManyToOne(() => Brand, { onDelete: 'CASCADE', eager: false })
  @JoinColumn({ name: 'brandId' })
  brand!: Brand;

  @Column('uuid')
  brandId!: string;

  @ManyToOne(() => Category, { onDelete: 'CASCADE', eager: false })
  @JoinColumn({ name: 'categoryId' })
  category!: Category;

  @Column('uuid')
  categoryId!: string;

  @CreateDateColumn()
  createdAt!: Date;
}
