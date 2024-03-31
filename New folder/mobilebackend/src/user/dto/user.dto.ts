import { Role } from "@prisma/client"
import { IsBoolean, IsNotEmpty, IsOptional, IsString } from "class-validator"

export class UserUpdateDto{
    
    @IsString()
    email: string

    @IsNotEmpty()
    @IsString()
    password: string

   
    @IsString()
    phoneNumber: string

    
    @IsString()
    firstName: string

    @IsOptional()
    @IsString()
    lastName?: string;

    @IsOptional()
    @IsString()
    pic?: string;

    @IsOptional()
    @IsString()
    role: Role;



}


