import { Module } from '@nestjs/common';
import { databaseProviders } from '../config/config.service';

@Module({
  providers: [...databaseProviders],
  exports: [...databaseProviders],
})
export class DatabaseModule {}
