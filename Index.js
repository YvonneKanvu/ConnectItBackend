
const express = require("express");
const PORT = 3000;
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient(); 
const jwt = require('jsonwebtoken');
const dotenv = require("dotenv");
dotenv.config();
const bcrypt =require("bcrypt")
const app = express();
app.use(express.json());
app.use(
  express.urlencoded({
    extended: true,
  })  
);  
// console.log(process.env.SECRET_KEY);

// //  ajouter Geolocalisation
// app.post("/geolocalisation", async (req, res) => {
//   try {
    
//     const {Adresse, Laltitude, Longitude} = req.body;

//     const createdGeolocalisation = await prisma.geolocalisation.create({
//       data: 
//         { 
//         Adresse : Adresse,
//         Laltitude  : Laltitude,
//         Longitude : Longitude,

//         }
//     });
//     res.status(201).json({
//       message: 'Geolocalisation créé avec succès',
//       Geolocalisation: createdGeolocalisation
//     });
//   } catch (error) {
//     console.error(error);
//     res.status(500).json({ message: 'Erreur lors de la création du Geolocalisation'});
//   }
// });

if (!process.env.SECRET_KEY) {
  console.error("SECRET_KEY n'est pas défini dans les variables d'environnement");
  process.exit(1);
}


 app.post("/user/create",async (req, res)=> {
 const {prenom, nom, email, telephone, password} = req.body
 try{
  // Vérification si l'e-mail existe déjà dans la base de données
 const existingUser = await prisma.utilisateur.findFirst({
    where: { 
      email: email
     },
 });
  if (existingUser) {
   return res.status(400).json({ message: "Cet email existe déjà" });
   }
console.log(prenom, nom, email, telephone, password)
 const saltgen = bcrypt.genSaltSync(12)
 const passwordHash = bcrypt.hashSync(password, saltgen)
 // Création de l'utilisateur dans la base de données
 const user = await prisma.utilisateur.create({
  data: {
   nom,
   prenom,
   email,
  telephone,
   password :passwordHash,
  } 
 })
  //  res.json({user})
 const token = jwt.sign({ userId: user.id }, process.env.SECRET_KEY)
return res.status(201).json({
   message: "Utilisateur enregistré avec succès",
  token,
   user,
 });
 } catch (error) {
 console.error("Error creating user:", error);
 return res.status(500).json({ error: "Une erreur est survenue lors de la création de l'utilisateur" });
 }
 });



  //  Route de connexion
// console.log('SECRET_KEY:', process.env.SECRET_KEY);
//  if (!process.env.SECRET_KEY) {
//   console.error('SECRET_KEY n\'est pas défini dans les variables d\'environnement');
//  process.exit(1);
//    }
app.post("/login", async (req, res) => {
   const { email, password } = req.body;
    try{
      const Utilisateur = await prisma.utilisateur.findFirst({
        where: { 
          email: email
       }
      });
   console.log(Utilisateur);
      if (!Utilisateur) {
        return res.status(401).json({ message: "Identifiants incorrects" });
     }
     const isPasswordValid = await bcrypt.compare(password, Utilisateur.password);
    if (!isPasswordValid) {
     return res.status(401).json({ message: "Identifiants incorrects" });
     }
  
      const token = jwt.sign({ UtilisateurId: Utilisateur.id }, process.env.SECRET_KEY);
  
    res.status(200).json({ message: "Connexion réussie", token });
    } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Erreur interne du serveur" });
  }
 });





app.listen(PORT,() => {
    console.log(`le Serveur ecoute sur le port ${PORT}`)
})


