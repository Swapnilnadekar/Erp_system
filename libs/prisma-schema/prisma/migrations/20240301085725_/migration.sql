/*
  Warnings:

  - You are about to drop the column `cOllegeADMINId` on the `comps` table. All the data in the column will be lost.
  - You are about to drop the column `cOllegeADMINId` on the `entcs` table. All the data in the column will be lost.
  - You are about to drop the column `cOllegeADMINId` on the `its` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "comps" DROP CONSTRAINT "comps_cOllegeADMINId_fkey";

-- DropForeignKey
ALTER TABLE "entcs" DROP CONSTRAINT "entcs_cOllegeADMINId_fkey";

-- DropForeignKey
ALTER TABLE "its" DROP CONSTRAINT "its_cOllegeADMINId_fkey";

-- AlterTable
ALTER TABLE "colleges" ADD COLUMN     "cOllegeADMINId" INTEGER;

-- AlterTable
ALTER TABLE "comps" DROP COLUMN "cOllegeADMINId";

-- AlterTable
ALTER TABLE "entcs" DROP COLUMN "cOllegeADMINId";

-- AlterTable
ALTER TABLE "its" DROP COLUMN "cOllegeADMINId";

-- AddForeignKey
ALTER TABLE "colleges" ADD CONSTRAINT "colleges_cOllegeADMINId_fkey" FOREIGN KEY ("cOllegeADMINId") REFERENCES "collegeadmins"("id") ON DELETE SET NULL ON UPDATE CASCADE;
