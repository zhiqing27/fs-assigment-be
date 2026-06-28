import { IsUUID } from 'class-validator';

export class CreateOrderDto {
  productColorId!: string;

  @IsUUID('4')
  clientId!: string;
}
