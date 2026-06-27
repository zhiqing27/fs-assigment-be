import { DataSource } from 'typeorm';
require('dotenv').config();

export default new DataSource({
  type: 'postgres',
  host: process.env.POSTGRES_HOST,
  port: parseInt(process.env.POSTGRES_PORT ?? '5432', 10),
  username: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
  database: process.env.POSTGRES_DATABASE,
  entities: ['src/**/*.entity{.ts,.js}'],
  migrations: ['src/migration/*.ts'],
  migrationsTableName: 'migration',
  synchronize: process.env.NODE_ENV !== 'production',
});
