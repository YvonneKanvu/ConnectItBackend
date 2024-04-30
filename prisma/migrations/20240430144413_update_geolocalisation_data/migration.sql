/*
  Warnings:

  - You are about to drop the column `Id` on the `Geolocalisation` table. All the data in the column will be lost.
  - You are about to drop the column `Id` on the `Prestataire` table. All the data in the column will be lost.
  - Changed the type of `Laltitude` on the `Geolocalisation` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `Longitude` on the `Geolocalisation` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `Nom` to the `Prestataire` table without a default value. This is not possible if the table is not empty.
  - Added the required column `PreNom` to the `Prestataire` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Secteur` to the `Prestataire` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "AvisEtRecommandention" DROP CONSTRAINT "AvisEtRecommandention_PrestataireId_fkey";

-- DropForeignKey
ALTER TABLE "DemandeDeDevis" DROP CONSTRAINT "DemandeDeDevis_PrestataireId_fkey";

-- DropForeignKey
ALTER TABLE "Fournir" DROP CONSTRAINT "Fournir_PrestataireId_fkey";

-- DropForeignKey
ALTER TABLE "Intervention" DROP CONSTRAINT "Intervention_PrestataireId_fkey";

-- DropForeignKey
ALTER TABLE "Message" DROP CONSTRAINT "Message_PrestataireId_fkey";

-- DropForeignKey
ALTER TABLE "Prestataire" DROP CONSTRAINT "Prestataire_GeolocalisationId_fkey";

-- DropIndex
DROP INDEX "Geolocalisation_Id_key";

-- DropIndex
DROP INDEX "Prestataire_Id_key";

-- AlterTable
CREATE SEQUENCE avisetrecommandention_id_seq;
ALTER TABLE "AvisEtRecommandention" ALTER COLUMN "Id" SET DEFAULT nextval('avisetrecommandention_id_seq');
ALTER SEQUENCE avisetrecommandention_id_seq OWNED BY "AvisEtRecommandention"."Id";

-- AlterTable
CREATE SEQUENCE demandededevis_id_seq;
ALTER TABLE "DemandeDeDevis" ALTER COLUMN "Id" SET DEFAULT nextval('demandededevis_id_seq');
ALTER SEQUENCE demandededevis_id_seq OWNED BY "DemandeDeDevis"."Id";

-- AlterTable
CREATE SEQUENCE fournir_id_seq;
ALTER TABLE "Fournir" ALTER COLUMN "Id" SET DEFAULT nextval('fournir_id_seq');
ALTER SEQUENCE fournir_id_seq OWNED BY "Fournir"."Id";

-- AlterTable
ALTER TABLE "Geolocalisation" DROP COLUMN "Id",
ADD COLUMN     "id" SERIAL NOT NULL,
DROP COLUMN "Laltitude",
ADD COLUMN     "Laltitude" DOUBLE PRECISION NOT NULL,
DROP COLUMN "Longitude",
ADD COLUMN     "Longitude" DOUBLE PRECISION NOT NULL,
ADD CONSTRAINT "Geolocalisation_pkey" PRIMARY KEY ("id");

-- AlterTable
CREATE SEQUENCE intervention_id_seq;
ALTER TABLE "Intervention" ALTER COLUMN "Id" SET DEFAULT nextval('intervention_id_seq');
ALTER SEQUENCE intervention_id_seq OWNED BY "Intervention"."Id";

-- AlterTable
CREATE SEQUENCE message_id_seq;
ALTER TABLE "Message" ALTER COLUMN "Id" SET DEFAULT nextval('message_id_seq');
ALTER SEQUENCE message_id_seq OWNED BY "Message"."Id";

-- AlterTable
ALTER TABLE "Prestataire" DROP COLUMN "Id",
ADD COLUMN     "Nom" TEXT NOT NULL,
ADD COLUMN     "PreNom" TEXT NOT NULL,
ADD COLUMN     "Secteur" TEXT NOT NULL,
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "Prestataire_pkey" PRIMARY KEY ("id");

-- AlterTable
CREATE SEQUENCE utilisateur_id_seq;
ALTER TABLE "Utilisateur" ALTER COLUMN "Id" SET DEFAULT nextval('utilisateur_id_seq');
ALTER SEQUENCE utilisateur_id_seq OWNED BY "Utilisateur"."Id";

-- CreateTable
CREATE TABLE "Secteur" (
    "Id" SERIAL NOT NULL,
    "Designation" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Appartenir" (
    "Id" SERIAL NOT NULL,
    "PrestataireId" INTEGER,
    "SecteurId" INTEGER
);

-- CreateIndex
CREATE UNIQUE INDEX "Secteur_Id_key" ON "Secteur"("Id");

-- CreateIndex
CREATE UNIQUE INDEX "Appartenir_Id_key" ON "Appartenir"("Id");

-- AddForeignKey
ALTER TABLE "Prestataire" ADD CONSTRAINT "Prestataire_GeolocalisationId_fkey" FOREIGN KEY ("GeolocalisationId") REFERENCES "Geolocalisation"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Fournir" ADD CONSTRAINT "Fournir_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DemandeDeDevis" ADD CONSTRAINT "DemandeDeDevis_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AvisEtRecommandention" ADD CONSTRAINT "AvisEtRecommandention_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Intervention" ADD CONSTRAINT "Intervention_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appartenir" ADD CONSTRAINT "Appartenir_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appartenir" ADD CONSTRAINT "Appartenir_SecteurId_fkey" FOREIGN KEY ("SecteurId") REFERENCES "Secteur"("Id") ON DELETE SET NULL ON UPDATE CASCADE;
