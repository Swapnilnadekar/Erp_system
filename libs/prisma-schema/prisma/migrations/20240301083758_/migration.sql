/*
  Warnings:

  - You are about to drop the column `role` on the `users` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "SuperRoleName" AS ENUM ('ADMIN');

-- CreateEnum
CREATE TYPE "CollegeRoleName" AS ENUM ('PRINCIPAL', 'HOD', 'ADMIN', 'PROFESSOR');

-- AlterTable
ALTER TABLE "users" DROP COLUMN "role",
ADD COLUMN     "token" TEXT,
ALTER COLUMN "password" DROP NOT NULL;

-- DropEnum
DROP TYPE "Role";

-- CreateTable
CREATE TABLE "super_roles" (
    "id" SERIAL NOT NULL,
    "name" "SuperRoleName" NOT NULL,

    CONSTRAINT "super_roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "college_roles" (
    "id" SERIAL NOT NULL,
    "name" "CollegeRoleName" NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "college_roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users_super_roles" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "super_role_id" INTEGER NOT NULL,

    CONSTRAINT "users_super_roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users_college_roles" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "college_role_id" INTEGER NOT NULL,
    "college_id" INTEGER NOT NULL,
    "is_primary" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "users_college_roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "colleges" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "address_line_1" TEXT NOT NULL,
    "address_line_2" TEXT,
    "city" TEXT NOT NULL,
    "postal_code" TEXT NOT NULL,
    "country_code" TEXT NOT NULL,
    "state_code" TEXT,
    "email" TEXT,
    "phone_number" TEXT,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ,
    "is_active" BOOLEAN NOT NULL,
    "code" TEXT NOT NULL,

    CONSTRAINT "colleges_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "comps" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "college_id" INTEGER NOT NULL,
    "student_id" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ,

    CONSTRAINT "comps_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "its" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "college_id" INTEGER NOT NULL,
    "student_id" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ,

    CONSTRAINT "its_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "entcs" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "college_id" INTEGER NOT NULL,
    "student_id" INTEGER NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ,

    CONSTRAINT "entcs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "students" (
    "id" SERIAL NOT NULL,
    "studentcode" TEXT NOT NULL,
    "branch" TEXT NOT NULL,
    "class" TEXT NOT NULL,
    "firstname" TEXT NOT NULL,
    "middlename" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "dob" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "students_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "super_roles_name_key" ON "super_roles"("name");

-- CreateIndex
CREATE UNIQUE INDEX "college_roles_name_key" ON "college_roles"("name");

-- CreateIndex
CREATE UNIQUE INDEX "colleges_code_key" ON "colleges"("code");

-- CreateIndex
CREATE UNIQUE INDEX "comps_name_college_id_key" ON "comps"("name", "college_id");

-- CreateIndex
CREATE UNIQUE INDEX "its_name_college_id_key" ON "its"("name", "college_id");

-- CreateIndex
CREATE UNIQUE INDEX "entcs_name_college_id_key" ON "entcs"("name", "college_id");

-- CreateIndex
CREATE UNIQUE INDEX "students_studentcode_key" ON "students"("studentcode");

-- AddForeignKey
ALTER TABLE "college_roles" ADD CONSTRAINT "college_roles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_super_roles" ADD CONSTRAINT "users_super_roles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_super_roles" ADD CONSTRAINT "users_super_roles_super_role_id_fkey" FOREIGN KEY ("super_role_id") REFERENCES "super_roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_college_roles" ADD CONSTRAINT "users_college_roles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_college_roles" ADD CONSTRAINT "users_college_roles_college_role_id_fkey" FOREIGN KEY ("college_role_id") REFERENCES "college_roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_college_roles" ADD CONSTRAINT "users_college_roles_college_id_fkey" FOREIGN KEY ("college_id") REFERENCES "colleges"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comps" ADD CONSTRAINT "comps_college_id_fkey" FOREIGN KEY ("college_id") REFERENCES "colleges"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comps" ADD CONSTRAINT "comps_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "its" ADD CONSTRAINT "its_college_id_fkey" FOREIGN KEY ("college_id") REFERENCES "colleges"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "its" ADD CONSTRAINT "its_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "entcs" ADD CONSTRAINT "entcs_college_id_fkey" FOREIGN KEY ("college_id") REFERENCES "colleges"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "entcs" ADD CONSTRAINT "entcs_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
