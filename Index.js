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

//  ajouter Geolocalisation
app.post("/geolocalisation", async (req, res) => {
  try {
    
    const {Adresse, Laltitude, Longitude} = req.body;

    const createdGeolocalisation = await prisma.geolocalisation.create({
      data: 
        { 
        Adresse : Adresse,
        Laltitude  : Laltitude,
        Longitude : Longitude,

        }
    });
    res.status(201).json({
      message: 'Geolocalisation créé avec succès',
      Geolocalisation: createdGeolocalisation
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Erreur lors de la création du Geolocalisation'});
  }
});
// ajouter prestataire
 app.post("/prestataire", async (req, res) => {
  try {
    const { Nom, PreNom, Adesse, Email, Telephone, Secteur, NomDeL_entreprise, Adresse, GeolocalisationId} = req.body;

    const createdPrestataire = await prisma.prestataire.create({
      data: 
        {
          Nom: Nom,
          PreNom: PreNom,
          Adesse: Adesse,
          Email: Email,
          Telephone: Telephone,
          Secteur: Secteur,
          NomDeL_entreprise :NomDeL_entreprise,
          GeolocalisationId : GeolocalisationId
          // Geolocalisation: {
          //   create: {
          //     Adresse: Adresse.ligne,
          //     Laltitude: Adresse.lat,
          //     Longitude: Adresse.long
          //   }
          // }
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



