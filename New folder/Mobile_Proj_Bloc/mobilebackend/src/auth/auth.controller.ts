import { Body, Controller, Post, UseGuards, Request, Get, ParseIntPipe, Param, Logger, HttpException, HttpStatus,   } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthDto,  UserDto } from './dto';
import { JwtAuthGuard } from './guard/auth.guard';

import { Role } from '@prisma/client';
import { Public } from './decorator/public.decorator';
import { RolesGuard } from './guard/role.guard';
import { Roles } from './decorator/roles.decorator';
import { ValidationError } from 'class-validator';

@Public()
@Controller('auth')
export class AuthController {
    constructor(private authService: AuthService) {}

    @Post('signup')
    async Signup(@Body() dto: UserDto) {
        try {
            // Perform validation logic here (if any)
            // For example, you might use class-validator decorators on your DTOs
            
            // Call the service method for user signup
            let response = await this.authService.userSignup(dto);
            return response;
        } catch (error) {
            console.error('Error during signup:', error);

            // Handle validation errors specifically
            if (error instanceof ValidationError) {
                // If it's a validation error, construct a response with the error message
                const constraints = Object.values(error.constraints);
                const message = constraints.join(', '); // Join all constraints into a single message
                throw new HttpException({ message }, HttpStatus.BAD_REQUEST);
            } else if (error.name === 'ValidationError') {
                // Handle potential custom ValidationError (optional)
            }

            // Handle other errors (optional)
            // You can add more specific error handling for other types of errors here if needed

            // Re-throw the error if it's not a validation error
            throw error;
        }
    }

  


    @Post('signin')
    login(@Body() dto: AuthDto) {
        console.log("signing in");
        return this.authService.signin(dto);
    }

    

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Roles(Role.ADMIN, Role.USER)
    @Get('profile')
    getProfile(@Request() req){
        return req.user
    }

  
    

    @Post('logout')
    logout() {}

   
}
