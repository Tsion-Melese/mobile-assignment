
import { BadRequestException, Injectable, InternalServerErrorException, NotFoundException } from '@nestjs/common';
import * as argon2 from 'argon2';
import { Prisma, User } from '@prisma/client'; 
import { PrismaService } from '../prisma/prisma.service';
import { UserUpdateDto } from './dto/user.dto';

type HashFunction = (password: string, saltOrRounds: number) => Promise<string>;
type UserProfile = {
  id: number;
  email: string;
firstName: string
 lastName?: string;
pic?: string;
} | null;


@Injectable()
export class UserService {
  constructor(private readonly db: PrismaService) {}

async getAllUsers(): Promise<User[]> {
    try {
      const allUsers = await this.db.user.findMany();
      return allUsers;
    } catch (error) {
      console.error('Error getting all users:', error);
      throw new InternalServerErrorException('Something went wrong');
    }
  }
  


  async deleteUser(userId: number) {
    try {
      await this.db.user.delete({
        where: { id: userId },
      });
      return {
        statusCode: 200,
        message: `User with ID ${userId} successfully deleted`,
      };
    } catch (error) {
      console.error('Error deleting user:', error);
      throw new Error('Failed to delete user.');
    }
  }
  
  

 
 

  async updateUser(userId: number, dto: UserUpdateDto) {
      try {
          console.log('Received userId:', userId);
  
          if (!userId) {
              throw new BadRequestException('UserId is required for updating the user.');
          }
  
          // Hash the password if it's provided in the update DTO
          if (dto.password) {
              const hashedPassword = await argon2.hash(dto.password); // Hash the password using Argon2
              dto.password = hashedPassword;
          }
  
          const user = await this.db.user.update({
              where: { id: userId },
              data: { ...dto },
          });
  
          return user;
      } catch (error) {
          console.error('Error updating user:', error);
          throw new InternalServerErrorException('Something went wrong');
      }
  }
  
  
  


  
  async getProfile(userId: number): Promise<UserProfile> {
    try {
      const userProfile = await this.db.user.findUnique({
        where: { id: userId },
        select: {
          id: true,
          
          email: true,
          firstName:true,
          lastName:true,
          pic:true,
        },
      });
  
      if (!userProfile) {
        throw new NotFoundException(`User with ID ${userId} not found`);
      }
  
      return userProfile;
    } catch (error) {
      console.error('Error getting user profile:', error);
      throw new InternalServerErrorException('Something went wrong');
    }
  }
  

  

  async getUserById(userId: number): Promise<User | null> {
    return this.db.user.findUnique({
      where: { id: userId },
    });
  }
  async updateUserBlockStatus(userId: number, isBlocked: boolean): Promise<void> {
    try {
        const user = await this.db.user.findUnique({
            where: { id: userId },
        });

        if (!user) {
            throw new NotFoundException(`User with ID ${userId} not found`);
        }

        // Update the user's block status
        await this.db.user.update({
            where: { id: userId },
            data: { isBlocked },
        });

        // Additional cleanup or follow-up actions can be added here
        
        return; // Return to fulfill Promise<void>
    } catch (error) {
        // Handle errors
        console.error("Error occurred:", error);
        throw error; // Rethrow the error
    }
}

}





  
  
  
  
  
  
  