-- CreateTable
CREATE TABLE "Prestataire" (
    "Id" INTEGER NOT NULL,
    "NomDeL_entreprise" TEXT NOT NULL,
    "Adesse" TEXT NOT NULL,
    "Email" TEXT NOT NULL,
    "Telephone" TEXT NOT NULL,
    "GeolocalisationId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "Geolocalisation" (
    "Id" INTEGER NOT NULL,
    "Adresse" TEXT NOT NULL,
    "Laltitude" TEXT NOT NULL,
    "Longitude" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Utilisateur" (
    "Id" INTEGER NOT NULL,
    "Nom" TEXT NOT NULL,
    "PreNom" TEXT NOT NULL,
    "Email" TEXT NOT NULL,
    "Telephone" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Fournir" (
    "Id" INTEGER NOT NULL,
    "PrestataireId" INTEGER,
    "UtilisateurId" INTEGER
);

-- CreateTable
CREATE TABLE "DemandeDeDevis" (
    "Id" INTEGER NOT NULL,
    "TypeDeService" TEXT NOT NULL,
    "Statut" TEXT NOT NULL,
    "Date" TIMESTAMP(3) NOT NULL,
    "PrestataireId" INTEGER,
    "UtilisateurId" INTEGER
);

-- CreateTable
CREATE TABLE "AvisEtRecommandention" (
    "Id" INTEGER NOT NULL,
    "Note" TEXT NOT NULL,
    "Commentaire" TEXT NOT NULL,
    "Date" TIMESTAMP(3) NOT NULL,
    "PrestataireId" INTEGER,
    "UtilisateurId" INTEGER
);

-- CreateTable
CREATE TABLE "Message" (
    "Id" INTEGER NOT NULL,
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
    "Id" INTEGER NOT NULL,
    "Description" TEXT NOT NULL,
    "Statut" TEXT NOT NULL,
    "Date" TIMESTAMP(3) NOT NULL,
    "PrestataireId" INTEGER,
    "UtilisateurId" INTEGER
);

-- CreateIndex
CREATE UNIQUE INDEX "Prestataire_Id_key" ON "Prestataire"("Id");

-- CreateIndex
CREATE UNIQUE INDEX "Geolocalisation_Id_key" ON "Geolocalisation"("Id");

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

-- AddForeignKey
ALTER TABLE "Prestataire" ADD CONSTRAINT "Prestataire_GeolocalisationId_fkey" FOREIGN KEY ("GeolocalisationId") REFERENCES "Geolocalisation"("Id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Fournir" ADD CONSTRAINT "Fournir_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Fournir" ADD CONSTRAINT "Fournir_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DemandeDeDevis" ADD CONSTRAINT "DemandeDeDevis_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DemandeDeDevis" ADD CONSTRAINT "DemandeDeDevis_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AvisEtRecommandention" ADD CONSTRAINT "AvisEtRecommandention_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AvisEtRecommandention" ADD CONSTRAINT "AvisEtRecommandention_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Intervention" ADD CONSTRAINT "Intervention_PrestataireId_fkey" FOREIGN KEY ("PrestataireId") REFERENCES "Prestataire"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Intervention" ADD CONSTRAINT "Intervention_UtilisateurId_fkey" FOREIGN KEY ("UtilisateurId") REFERENCES "Utilisateur"("Id") ON DELETE SET NULL ON UPDATE CASCADE;
