import { Controller, Get, Post, Patch, Param, Body, Query, Headers } from '@nestjs/common';
import { OrderService } from './order.service';
import { CreateOrderDto } from './dtos/create-order.dto';
import { FindOrdersQueryDto } from './dtos/find-orders-query.dto';

@Controller('order')
export class OrderController {
  constructor(private readonly orderService: OrderService) {}

  @Post()
  create(@Body() dto: CreateOrderDto) {
    return this.orderService.create(dto);
  }

  @Get()
  findAll(@Headers('x-client-id') clientId: string, @Query() query: FindOrdersQueryDto) {
    return this.orderService.findAll(clientId, query);
  }

  @Patch(':id/complete')
  complete(@Param('id') id: string) {
    return this.orderService.complete(id);
  }
}
