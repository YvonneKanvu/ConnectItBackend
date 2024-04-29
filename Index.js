const express = require("express");
const PORT = 3000;

const app = express();
app.use(express.json());

//console sur le navigateur
app.get("/", (req, res) => {
    res.send("L'application fonctionne")
  });

// liste prestataires
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient(); 
// const { Int } = require('@prisma/client/runtime'); 

 app.get("/prestataires", async (req, res) => {
    try {
     const prestataires = await prisma.prestataire.findMany();
    res.json(prestataires);
   } catch (error) {
    console.error(error);
   res.status(500).send("Error retrieving prestataires");
   }
 });
  
 // prestataire par ID
app.get("/prestataire/:Id", async (req, res) => {

   const Id =  parseInt(req.params.Id);
   try {
    const prestataire = await prisma.prestataire.findUnique({
      where: {
       Id: Id,
     },
    });
    if (!prestataire) {
        res.status(404).send("Prestataire not found");
       return;
     }
     res.json(prestataire);
   } catch (error) {
     console.error(error);
     res.status(500).send("Error server");
   }
  });
  
 // prestataire par geolocalisation
app.get("/prestataire/:localisation", async (req, res) => {
   res.json({ message: "Recherche par géolocalisation pas encore implémentée" });
 });
//  ajouter un prestataire
 app.post("/prestataire", async (req, res) => {
  try {
    const { Nom, PreNom, Adesse, Email, Telephone, Secteur,Id, NomDeL_entreprise, Geolocalisation} = req.body;

    const createdPrestataire = await prisma.prestataire.create({
      data: 
        {
          Nom: Nom,
          PreNom: PreNom,
          Adesse: Adesse,
          Email: Email,
          Telephone: Telephone,
          Secteur: Secteur,
          Id : Id,
          NomDeL_entreprise :NomDeL_entreprise,
          Geolocalisation : Geolocalisation
        }
    });
    res.status(201).json({
      message: 'Prestataire créé avec succès',
      prestataire: createdPrestataire
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la création du prestataire'});
  }
});

app.listen(PORT,() => {
    console.log(`le Serveur ecoute sur le port ${PORT}`)
})



