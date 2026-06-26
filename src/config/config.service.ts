import { DataSource } from 'typeorm';

require('dotenv').config();

export const databaseProviders = [
  {
    provide: 'DATA_SOURCE',
    useFactory: async () => {
      const dataSource = new DataSource({
        type: 'postgres',
        host: process.env.POSTGRES_HOST,
        port: parseInt(process.env.POSTGRES_PORT ?? '5432', 10),
        username: process.env.POSTGRES_USER,
        password: process.env.POSTGRES_PASSWORD,
        database: process.env.POSTGRES_DATABASE,
        entities: [__dirname + '/../**/*.entity{.ts,.js}'],
        synchronize: process.env.MODE === 'DEV',
      });

      return dataSource.initialize();
    },
  },
];
