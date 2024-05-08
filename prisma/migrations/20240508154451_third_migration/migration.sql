/*
  Warnings:

  - You are about to drop the column `Email` on the `Utilisateur` table. All the data in the column will be lost.
  - You are about to drop the column `Nom` on the `Utilisateur` table. All the data in the column will be lost.
  - You are about to drop the column `PreNom` on the `Utilisateur` table. All the data in the column will be lost.
  - You are about to drop the column `Telephone` on the `Utilisateur` table. All the data in the column will be lost.
  - Added the required column `email` to the `Utilisateur` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nom` to the `Utilisateur` table without a default value. This is not possible if the table is not empty.
  - Added the required column `preNom` to the `Utilisateur` table without a default value. This is not possible if the table is not empty.
  - Added the required column `telephone` to the `Utilisateur` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Utilisateur" DROP COLUMN "Email",
DROP COLUMN "Nom",
DROP COLUMN "PreNom",
DROP COLUMN "Telephone",
ADD COLUMN     "email" TEXT NOT NULL,
ADD COLUMN     "nom" TEXT NOT NULL,
ADD COLUMN     "preNom" TEXT NOT NULL,
ADD COLUMN     "telephone" TEXT NOT NULL;
