import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Product } from '../entities/product.entity';
import { ProductColor } from '../entities/product-color.entity';
import { Color } from '../entities/color.entity';
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
  private colorRepository: Repository<Color>;

  constructor(private dataSource: DataSource) {
    this.productRepository = this.dataSource.getRepository(Product);
    this.brandRepository = this.dataSource.getRepository(Brand);
    this.categoryRepository = this.dataSource.getRepository(Category);
    this.colorRepository = this.dataSource.getRepository(Color);
  }

  async findAll(query: FindProductsQueryDto): Promise<FindProductsResponseDto> {
    const { name, categoryId, brandId, color, limit, offset } = query;

    const qb = this.productRepository
      .createQueryBuilder('product')
      .leftJoinAndSelect('product.brand', 'brand')
      .leftJoinAndSelect('product.category', 'category')
      .leftJoinAndSelect('product.colors', 'productColor')
      .leftJoinAndSelect('productColor.color', 'color');

    if (name) {
      qb.andWhere('product.name ILIKE :name', { name: `%${name}%` });
    }

    if (categoryId) {
      qb.andWhere('product.categoryId = :categoryId', { categoryId });
    }

    if (brandId) {
      qb.andWhere('product.brandId = :brandId', { brandId });
    }

    if (color) {
      qb.andWhere(
        'EXISTS (SELECT 1 FROM product_colors pc WHERE pc."productId" = product.id AND pc."colorId" = :color)',
        { color },
      );
    }

    const [products, total] = await qb
      .orderBy('product.name', 'ASC')
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
      categoryId: product.category.id,
      categoryName: product.category.name,
      colors: product.colors.map((pc) => ({
        id: pc.id,
        name: pc.color.name,
        colorCode: pc.color.colorCode,
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
  ): Promise<{ id: string; name: string; logoUrl: string | null }[]> {
    const qb = this.brandRepository
      .createQueryBuilder('brand')
      .select(['brand.id', 'brand.name', 'brand.logoUrl'])
      .orderBy('brand.name', 'ASC');

    if (categoryId) {
      qb.andWhere(
        'EXISTS (SELECT 1 FROM brand_categories bc WHERE bc."brandId" = brand.id AND bc."categoryId" = :categoryId)',
        { categoryId },
      );
    }

    return qb.getMany();
  }

  async getColors(): Promise<{ name: string; colorCode: string }[]> {
    return this.colorRepository.find({
      select: ['name', 'colorCode'],
      order: { name: 'ASC' },
    });
  }
}
