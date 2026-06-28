import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { ProductColor } from '../entities/product-color.entity';
import { Color } from '../entities/color.entity';
import { Category } from '../entities/category.entity';
import { Brand } from '../entities/brand.entity';
import { FindProductsQueryDto } from './dtos/requests/find-products-query.dto';
import {
  FindProductsResponseDto,
  ProductListingItemDto,
} from './dtos/responses/product-response.dto';

@Injectable()
export class ProductsService {
  private productColorRepository: Repository<ProductColor>;
  private brandRepository: Repository<Brand>;
  private categoryRepository: Repository<Category>;
  private colorRepository: Repository<Color>;

  constructor(private dataSource: DataSource) {
    this.productColorRepository = this.dataSource.getRepository(ProductColor);
    this.brandRepository = this.dataSource.getRepository(Brand);
    this.categoryRepository = this.dataSource.getRepository(Category);
    this.colorRepository = this.dataSource.getRepository(Color);
  }

  async findAll(query: FindProductsQueryDto): Promise<FindProductsResponseDto> {
    const { name, categoryId, brandId, color, limit, offset } = query;

    const qb = this.productColorRepository
      .createQueryBuilder('pc')
      .innerJoinAndSelect('pc.product', 'product')
      .innerJoinAndSelect('pc.color', 'color')
      .innerJoinAndSelect('product.brand', 'brand')
      .innerJoinAndSelect('product.category', 'category');

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
      qb.andWhere('pc.colorId = :color', { color });
    }

    const [items, total] = await qb
      .orderBy('product.name', 'ASC')
      .addOrderBy('color.name', 'ASC')
      .skip(offset)
      .take(limit)
      .getManyAndCount();

    return {
      data: items.map((pc) => this.mapToDto(pc)),
      total,
      limit,
      offset,
      totalPages: Math.ceil(total / limit),
    };
  }

  private mapToDto(pc: ProductColor): ProductListingItemDto {
    return {
      productColorId: pc.id,
      productId: pc.productId,
      name: `${pc.product.name} (${pc.color.name})`,
      price: Number(pc.price),
      imageUrl: pc.product.imageUrl,
      stock: pc.stock,
      brandId: pc.product.brand.id,
      brandName: pc.product.brand.name,
      categoryId: pc.product.category.id,
      categoryName: pc.product.category.name,
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
      select: ['name', 'colorCode', 'id'],
      order: { name: 'ASC' },
    });
  }
}
