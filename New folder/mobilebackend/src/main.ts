import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as dotenv from 'dotenv';
async function bootstrap() {
  dotenv.config(); // Call dotenv to load environment variables
  const app = await NestFactory.create(AppModule);
  await app.listen(3001);
}
bootstrap();
