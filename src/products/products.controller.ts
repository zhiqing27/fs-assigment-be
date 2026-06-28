import { Controller, Get, Query } from '@nestjs/common';
import { ProductsService } from './products.service';
import { FindProductsQueryDto } from './dtos/requests/find-products-query.dto';

@Controller('products')
export class ProductsController {
  constructor(private readonly productsService: ProductsService) {}

  @Get()
  findAll(@Query() query: FindProductsQueryDto) {
    return this.productsService.findAll(query);
  }

  @Get('filters/categories')
  async getCategories(): Promise<{ id: string; name: string }[]> {
    return this.productsService.getCategories();
  }

  @Get('filters/brands')
  async getBrands(
    @Query('categoryId') categoryId?: string,
  ): Promise<{ id: string; name: string; logoUrl: string | null }[]> {
    return this.productsService.getBrands(categoryId);
  }

  @Get('filters/colors')
  async getColors(): Promise<{ name: string; colorCode: string }[]> {
    return this.productsService.getColors();
  }
}
