import { IsOptional, IsString, IsInt, IsUUID, Min, Max } from 'class-validator';
import { Type } from 'class-transformer';

export class FindProductsQueryDto {
  @IsOptional()
  @IsString()
  name?: string;

  @IsOptional()
  categoryId?: string;

  @IsOptional()
  brandId?: string;

  @IsOptional()
  color?: string;

  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(100)
  limit: number = 10;

  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(0)
  offset: number = 0;
}
