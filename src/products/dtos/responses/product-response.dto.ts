export class ProductColorDto {
  id: string;
  name: string;
  colorCode: string;
  stock: number;
  price: number;
}

export class ProductResponseDto {
  id: string;
  name: string;
  imageUrl: string;
  basePrice: number;
  brandId: string;
  brandName: string;
  categoryId: string;
  categoryName: string;
  colors: ProductColorDto[];
}

export class FindProductsResponseDto {
  data: ProductResponseDto[];
  total: number;
  limit: number;
  offset: number;
  totalPages: number;
}
