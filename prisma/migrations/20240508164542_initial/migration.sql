/*
  Warnings:

  - You are about to drop the column `Adesse` on the `Prestataire` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `Utilisateur` table. All the data in the column will be lost.
  - You are about to drop the column `preNom` on the `Utilisateur` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[id]` on the table `Utilisateur` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `adresse` to the `Prestataire` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password` to the `Utilisateur` table without a default value. This is not possible if the table is not empty.
  - Added the required column `prenom` to the `Utilisateur` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "AvisEtRecommandention" DROP CONSTRAINT "AvisEtRecommandention_UtilisateurId_fkey";

-- DropForeignKey
ALTER TABLE "DemandeDeDevis" DROP CONSTRAINT "DemandeDeDevis_UtilisateurId_fkey";

-- DropForeignKey
ALTER TABLE "Fournir" DROP CONSTRAINT "Fournir_UtilisateurId_fkey";

-- DropForeignKey
ALTER TABLE "Intervention" DROP CONSTRAINT "Intervention_UtilisateurId_fkey";

-- DropForeignKey
ALTER TABLE "Message" DROP CONSTRAINT "Message_UtilisateurId_fkey";

-- DropForeignKey
ALTER TABLE "Prestataire" DROP CONSTRAINT "Prestataire_UtilisateurId_fkey";

-- DropIndex
DROP INDEX "Utilisateur_Id_key";

-- AlterTable
ALTER TABLE "Prestataire" DROP COLUMN "Adesse",
ADD COLUMN     "adresse" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Utilisateur" DROP COLUMN "Id",
DROP COLUMN "preNom",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD COLUMN     "password" TEXT NOT NULL,
ADD COLUMN     "prenom" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Utilisateur_id_key" ON "Utilisateur"("id");

-- AddForeignKey
ALTER TABLE "Prestataire" ADD CONSTRAINT "Prestataire_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Fournir" ADD CONSTRAINT "Fournir_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DemandeDeDevis" ADD CONSTRAINT "DemandeDeDevis_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AvisEtRecommandention" ADD CONSTRAINT "AvisEtRecommandention_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Intervention" ADD CONSTRAINT "Intervention_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("id") ON DELETE SET NULL ON UPDATE CASCADE;
