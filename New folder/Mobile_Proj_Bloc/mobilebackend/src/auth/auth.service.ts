import {
  BadRequestException,
  ForbiddenException,
  HttpException,
  HttpStatus,
  Injectable,
  Logger,
} from '@nestjs/common';
import * as argon from 'argon2';
import { AuthDto,  UserDto } from './dto';
import { PrismaService } from 'src/prisma/prisma.service';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class AuthService {
  private readonly logger = new Logger(AuthService.name);
  constructor(
    private prisma: PrismaService,
    private jwt: JwtService,
    private config: ConfigService,
  ) {}

  async signToken(userId: number, email: string, role: string) {
    const payload = {
      sub: userId,
      email: email,
      roles: [role],
    };
    const secret = this.config.get('JWT_SECRET');
    const expiry = 3600;
    const token = await this.jwt.signAsync(payload, {
      expiresIn: expiry,
      secret: secret,
    });

    return {
      access_token: token,
    };
  }

  async userSignup(dto: UserDto) {
    try {
      // Log the received UserDto
      this.logger.log('Received UserDto: ' + JSON.stringify(dto));
  
      // Check if any required fields are missing
      const requiredFields = ['username', 'email', 'password', 'firstName', 'lastName', 'role'];
      const missingFields = requiredFields.filter(field => !(field in dto));
      if (missingFields.length > 0) {
        throw new BadRequestException(`Missing required fields: ${missingFields.join(', ')}`);
      }
  
      const hash = await argon.hash(dto.password);
  
      if (
        await this.prisma.user.findUnique({
          where: { email: dto.email },
        })
      ) {
        throw new ForbiddenException('Email already exists. Please use a different email');
      }
  
      const user = await this.prisma.user.create({
        data: {
          email: dto.email,
          password: hash,
          username: dto.username,
          firstName: dto.firstName,
          lastName: dto.lastName,
          role: dto.role,
        },
      });
      return this.signToken(user.id, user.email, user.role);
    } catch (e) {
      if (e instanceof PrismaClientKnownRequestError) {
        if (e.code === 'P2002') {
          throw new ForbiddenException('Something went wrong.');
        }
      }
      this.logger.error('Error during user signup: ' + e.message); // Log the error message
      throw new ForbiddenException('Something went wrong.');
    }
  }
  

  
  async signin(dto: AuthDto) {
    const hash = await argon.hash(dto.password);
    try {
        const user = await this.prisma.user.findUnique({
            where: {
                email: dto.email,
            },
        });

        if (!user) {
            console.log("Incorrect credentials");
            throw new ForbiddenException('Incorrect Credentials!');
        }

        // Check if the user is blocked
        if (user.isBlocked) {
            console.log("User is blocked");
            throw new ForbiddenException('User is blocked. Please contact support.');
        }

        const passmatch = await argon.verify(user.password, dto.password);
        if (passmatch) {
            console.log("Correct password");
            return this.signToken(user.id, user.email, user.role);
        } else {
            console.log("Incorrect password");
            throw new HttpException(
                { message: 'Incorrect password' },
                HttpStatus.BAD_REQUEST,
            );
        }
    } catch (e) {
        console.error("Error occurred during signin:", e);
        if (e instanceof ForbiddenException) {
            // Handle the case of a blocked user
            throw e;
        } else {
            // Handle other errors as "Invalid credentials"
            throw new HttpException(
                { message: 'Invalid credentials' },
                HttpStatus.BAD_REQUEST,
            );
        }
    }
}

  
 
  

  logout() {}
}
