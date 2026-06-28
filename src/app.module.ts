import { Module } from '@nestjs/common';
import { APP_GUARD } from '@nestjs/core';
import { TypeOrmModule } from './datasource/typeorm.module';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ProductsModule } from './products/products.module';
import { ApiKeyGuard } from './common/guards/api-key.guard';
import { OrderModule } from './order/order.module';

require('dotenv').config();

@Module({
  imports: [TypeOrmModule, ProductsModule, OrderModule],
  controllers: [AppController],
  providers: [
    AppService,
    { provide: APP_GUARD, useClass: ApiKeyGuard },
  ],
})
export class AppModule {}
