export class ProductListingItemDto {
  productColorId: string;
  productId: string;
  name: string; 
  price: number;
  imageUrl: string;
  stock: number;
  brandId: string;
  brandName: string;
  categoryId: string;
  categoryName: string;
}

export class FindProductsResponseDto {
  data: ProductListingItemDto[];
  total: number;
  limit: number;
  offset: number;
  totalPages: number;
}
