import { IsString } from 'class-validator';

export class CreateOrderDto {
  @IsString()
  productColorId!: string;

  @IsString()
  clientId!: string;
}
