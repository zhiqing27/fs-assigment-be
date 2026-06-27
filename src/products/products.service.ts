import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Product } from '../entities/product.entity';
import { ProductColor } from '../entities/product-color.entity';
import { Category } from '../entities/category.entity';
import { Brand } from '../entities/brand.entity';
import { FindProductsQueryDto } from './dtos/requests/find-products-query.dto';
import {
  FindProductsResponseDto,
  ProductResponseDto,
} from './dtos/responses/product-response.dto';

@Injectable()
export class ProductsService {
  private productRepository: Repository<Product>;
  private brandRepository: Repository<Brand>;
  private categoryRepository: Repository<Category>;
  private productColorRepository: Repository<ProductColor>;

  constructor(private dataSource: DataSource) {
    this.productRepository = this.dataSource.getRepository(Product);
    this.brandRepository = this.dataSource.getRepository(Brand);
    this.categoryRepository = this.dataSource.getRepository(Category);
    this.productColorRepository = this.dataSource.getRepository(ProductColor);
  }

  async findAll(query: FindProductsQueryDto): Promise<FindProductsResponseDto> {
    const { name, categoryId, brandId, color, limit, offset } = query;

    const qb = this.productRepository
      .createQueryBuilder('product')
      .leftJoinAndSelect('product.brand', 'brand')
      .leftJoinAndSelect('brand.category', 'category')
      .leftJoinAndSelect('product.colors', 'color');

    if (name) {
      qb.andWhere('product.name ILIKE :name', {
        name: `%${name}%`,
      });
    }

    if (categoryId) {
      qb.andWhere('category.id = :categoryId', {
        categoryId,
      });
    }

    if (brandId) {
      qb.andWhere('brand.id = :brandId', {
        brandId,
      });
    }

    if (color) {
      qb.andWhere('color.name ILIKE :color', {
        color: `%${color}%`,
      });
    }

    const [products, total] = await qb
      .orderBy('product.name', 'ASC')
      .addOrderBy('color.name', 'ASC')
      .skip(offset)
      .take(limit)
      .getManyAndCount();

    return {
      data: products.map((product) => this.mapToDto(product)),
      total,
      limit,
      offset,
      totalPages: Math.ceil(total / limit),
    };
  }

  private mapToDto(product: Product): ProductResponseDto {
    return {
      id: product.id,
      name: product.name,
      imageUrl: product.imageUrl,
      basePrice: Number(product.basePrice),
      brandId: product.brand.id,
      brandName: product.brand.name,
      categoryId: product.brand.category.id,
      categoryName: product.brand.category.name,
      colors: product.colors.map((pc) => ({
        id: pc.id,
        name: pc.name,
        colorCode: pc.colorCode,
        stock: pc.stock,
        price: Number(pc.price),
      })),
    };
  }

  async getCategories(): Promise<{ id: string; name: string }[]> {
    return this.categoryRepository.find({
      select: ['id', 'name'],
      order: { name: 'ASC' },
    });
  }

  async getBrands(
    categoryId?: string,
  ): Promise<{ id: string; name: string; categoryId: string }[]> {
    return this.brandRepository.find({
      select: {
        id: true,
        name: true,
        categoryId: true,
      },
      where: categoryId ? { categoryId } : {},
      order: {
        name: 'ASC',
      },
    });
  }

  async getColorsUnique(): Promise<{ name: string; colorCode: string }[]> {
    return this.productColorRepository
      .createQueryBuilder('product_colors')
      .distinctOn(['product_colors.name'])
      .select([
        'product_colors.name AS name',
        'product_colors.colorCode AS colorCode',
      ])
      .orderBy('product_colors.name')
      .getRawMany();
  }
}
