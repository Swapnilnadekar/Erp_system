/*
  Warnings:

  - Added the required column `principal_id` to the `colleges` table without a default value. This is not possible if the table is not empty.
  - Added the required column `hod_id` to the `entcs` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "colleges" ADD COLUMN     "principal_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "comps" ADD COLUMN     "cOllegeADMINId" INTEGER,
ADD COLUMN     "cOllegeProfessorId" INTEGER,
ADD COLUMN     "hODId" INTEGER;

-- AlterTable
ALTER TABLE "entcs" ADD COLUMN     "cOllegeADMINId" INTEGER,
ADD COLUMN     "cOllegeProfessorId" INTEGER,
ADD COLUMN     "hod_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "its" ADD COLUMN     "cOllegeADMINId" INTEGER,
ADD COLUMN     "cOllegeProfessorId" INTEGER,
ADD COLUMN     "hODId" INTEGER;

-- CreateTable
CREATE TABLE "principals" (
    "id" SERIAL NOT NULL,
    "pricipalcode" TEXT NOT NULL,
    "firstname" TEXT NOT NULL,
    "middlename" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "dob" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "principals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "hods" (
    "id" SERIAL NOT NULL,
    "hodcode" TEXT NOT NULL,
    "branch" TEXT NOT NULL,
    "class" TEXT NOT NULL,
    "firstname" TEXT NOT NULL,
    "middlename" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "dob" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "hods_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "collegeadmins" (
    "id" SERIAL NOT NULL,
    "admincode" TEXT NOT NULL,
    "firstname" TEXT NOT NULL,
    "middlename" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "dob" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "collegeadmins_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "collegeprofessors" (
    "id" SERIAL NOT NULL,
    "professorcode" TEXT NOT NULL,
    "firstname" TEXT NOT NULL,
    "middlename" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "dob" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "collegeprofessors_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "principals_pricipalcode_key" ON "principals"("pricipalcode");

-- CreateIndex
CREATE UNIQUE INDEX "hods_hodcode_key" ON "hods"("hodcode");

-- CreateIndex
CREATE UNIQUE INDEX "collegeadmins_admincode_key" ON "collegeadmins"("admincode");

-- CreateIndex
CREATE UNIQUE INDEX "collegeprofessors_professorcode_key" ON "collegeprofessors"("professorcode");

-- AddForeignKey
ALTER TABLE "colleges" ADD CONSTRAINT "colleges_principal_id_fkey" FOREIGN KEY ("principal_id") REFERENCES "principals"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comps" ADD CONSTRAINT "comps_hODId_fkey" FOREIGN KEY ("hODId") REFERENCES "hods"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comps" ADD CONSTRAINT "comps_cOllegeADMINId_fkey" FOREIGN KEY ("cOllegeADMINId") REFERENCES "collegeadmins"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comps" ADD CONSTRAINT "comps_cOllegeProfessorId_fkey" FOREIGN KEY ("cOllegeProfessorId") REFERENCES "collegeprofessors"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "its" ADD CONSTRAINT "its_hODId_fkey" FOREIGN KEY ("hODId") REFERENCES "hods"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "its" ADD CONSTRAINT "its_cOllegeADMINId_fkey" FOREIGN KEY ("cOllegeADMINId") REFERENCES "collegeadmins"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "its" ADD CONSTRAINT "its_cOllegeProfessorId_fkey" FOREIGN KEY ("cOllegeProfessorId") REFERENCES "collegeprofessors"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "entcs" ADD CONSTRAINT "entcs_hod_id_fkey" FOREIGN KEY ("hod_id") REFERENCES "hods"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "entcs" ADD CONSTRAINT "entcs_cOllegeADMINId_fkey" FOREIGN KEY ("cOllegeADMINId") REFERENCES "collegeadmins"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "entcs" ADD CONSTRAINT "entcs_cOllegeProfessorId_fkey" FOREIGN KEY ("cOllegeProfessorId") REFERENCES "collegeprofessors"("id") ON DELETE SET NULL ON UPDATE CASCADE;
