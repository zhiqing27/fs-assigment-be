import { Body, Controller, Get, Param, Patch, Post, Query } from '@nestjs/common';
import { OrdersService } from './orders.service';
import { CreateOrderDto } from './dtos/create-order.dto';

@Controller('orders')
export class OrdersController {
  constructor(private readonly ordersService: OrdersService) {}

  @Post()
  create(@Body() dto: CreateOrderDto) {
    return this.ordersService.create(dto);
  }

  @Get()
  findByClientId(
    @Query('clientId') clientId: string,
    @Query('limit') limit = '10',
    @Query('offset') offset = '0',
  ) {
    return this.ordersService.findByClientId(clientId, parseInt(limit), parseInt(offset));
  }

  @Patch(':id/complete')
  setCompleted(@Param('id') id: string) {
    return this.ordersService.setCompleted(id);
  }
}
