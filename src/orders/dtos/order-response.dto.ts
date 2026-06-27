export class OrderResponseDto {
  orderId: string;
  orderNumber: string;
  productId: string;
  productName: string;
  productColor: string;
  status: string;
  createdAt: Date;
}

export class FindOrdersResponseDto {
  data: OrderResponseDto[];
  total: number;
  limit: number;
  offset: number;
  totalPages: number;
}
