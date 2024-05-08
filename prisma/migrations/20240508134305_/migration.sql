-- CreateTable
CREATE TABLE "Utilisateur" (
    "Id" SERIAL NOT NULL,
    "Nom" TEXT NOT NULL,
    "PreNom" TEXT NOT NULL,
    "Email" TEXT NOT NULL,
    "Telephone" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Prestataire" (
    "id" SERIAL NOT NULL,
    "Adesse" TEXT NOT NULL,
    "GeolocalisationId" INTEGER NOT NULL,
    "Secteur" TEXT NOT NULL,
    "NomDeL_entreprise" TEXT NOT NULL,
    "UtilisateurId" INTEGER NOT NULL,

    CONSTRAINT "Prestataire_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Geolocalisation" (
    "id" SERIAL NOT NULL,
    "Adresse" TEXT NOT NULL,
    "Laltitude" DOUBLE PRECISION NOT NULL,
    "Longitude" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "Geolocalisation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Fournir" (
    "Id" SERIAL NOT NULL,
    "PrestataireId" INTEGER,
    "UtilisateurId" INTEGER
);

-- CreateTable
CREATE TABLE "DemandeDeDevis" (
    "Id" SERIAL NOT NULL,
    "TypeDeService" TEXT NOT NULL,
    "Statut" TEXT NOT NULL,
    "Date" TIMESTAMP(3) NOT NULL,
    "PrestataireId" INTEGER,
    "UtilisateurId" INTEGER
);

-- CreateTable
CREATE TABLE "AvisEtRecommandention" (
    "Id" SERIAL NOT NULL,
    "Note" TEXT NOT NULL,
    "Commentaire" TEXT NOT NULL,
    "Date" TIMESTAMP(3) NOT NULL,
    "PrestataireId" INTEGER,
    "UtilisateurId" INTEGER
);

-- CreateTable
CREATE TABLE "Message" (
    "Id" SERIAL NOT NULL,
    "Expediteur" TEXT NOT NULL,
    "Destinataire" TEXT NOT NULL,
    "Contenu" TEXT NOT NULL,
    "Statut" TEXT NOT NULL,
    "Date" TIMESTAMP(3) NOT NULL,
    "PrestataireId" INTEGER,
    "UtilisateurId" INTEGER
);

-- CreateTable
CREATE TABLE "Intervention" (
    "Id" SERIAL NOT NULL,
    "Description" TEXT NOT NULL,
    "Statut" TEXT NOT NULL,
    "Date" TIMESTAMP(3) NOT NULL,
    "PrestataireId" INTEGER,
    "UtilisateurId" INTEGER
);

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
CREATE UNIQUE INDEX "Utilisateur_Id_key" ON "Utilisateur"("Id");

-- CreateIndex
CREATE UNIQUE INDEX "Fournir_Id_key" ON "Fournir"("Id");

-- CreateIndex
CREATE UNIQUE INDEX "DemandeDeDevis_Id_key" ON "DemandeDeDevis"("Id");

-- CreateIndex
CREATE UNIQUE INDEX "AvisEtRecommandention_Id_key" ON "AvisEtRecommandention"("Id");

-- CreateIndex
CREATE UNIQUE INDEX "Message_Id_key" ON "Message"("Id");

-- CreateIndex
CREATE UNIQUE INDEX "Intervention_Id_key" ON "Intervention"("Id");

-- CreateIndex
CREATE UNIQUE INDEX "Secteur_Id_key" ON "Secteur"("Id");

-- CreateIndex
CREATE UNIQUE INDEX "Appartenir_Id_key" ON "Appartenir"("Id");

-- AddForeignKey
ALTER TABLE "Prestataire" ADD CONSTRAINT "Prestataire_GeolocalisationId_fkey" FOREIGN KEY ("GeolocalisationId") REFERENCES "Geolocalisation"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Prestataire" ADD CONSTRAINT "Prestataire_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("Id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Fournir" ADD CONSTRAINT "Fournir_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Fournir" ADD CONSTRAINT "Fournir_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DemandeDeDevis" ADD CONSTRAINT "DemandeDeDevis_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DemandeDeDevis" ADD CONSTRAINT "DemandeDeDevis_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AvisEtRecommandention" ADD CONSTRAINT "AvisEtRecommandention_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AvisEtRecommandention" ADD CONSTRAINT "AvisEtRecommandention_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Intervention" ADD CONSTRAINT "Intervention_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Intervention" ADD CONSTRAINT "Intervention_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appartenir" ADD CONSTRAINT "Appartenir_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appartenir" ADD CONSTRAINT "Appartenir_SecteurId_fkey" FOREIGN KEY ("SecteurId") REFERENCES "Secteur"("Id") ON DELETE SET NULL ON UPDATE CASCADE;
