import {  Role } from '@prisma/client/public';
import { Page } from './page';

export interface Users {
  id: number;
  referenceId?: string;
  firstName: string;
  lastName?: string;
  email: string;
  employeeId?:string;
  phoneNumber?:string | null;
  role: Role[];
  isActive:boolean;

}
export interface ViewUsers {
  id: number;
  referenceId?: string;
  firstName: string;
  lastName?: string;
  email: string;
  employeeId?:string;
  phoneNumber?:string | null;
  role: Role[];
  isActive: boolean;
}

export interface ViewUsersPW {
    id: number;
    referenceId?: string;
    firstName: string;
    lastName?: string;
    email: string;
    employeeId?:string;
    phoneNumber?:string | null;
    role: Role[];
    isActive: boolean;
  }

export interface Login {
  email: string;
  password: string;
}
export type ListUsers = ViewUsers;

export type AddUsers = Omit<Users, 'id'>;

export type ListUsersPage = Page<ListUsers>;