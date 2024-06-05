
// const express = require("express");
// const PORT = 3003;
// // const cors = require('cors');
// const { PrismaClient } = require('@prisma/client');
// const prisma = new PrismaClient(); 
// const jwt = require('jsonwebtoken');
// const dotenv = require("dotenv");
// dotenv.config();
// // app.use(cors());
// const bcrypt =require("bcrypt")
// const app = express();
// app.use(express.json());
// app.use(
//   express.urlencoded({
//     extended: true,
//   })  
// );  
// const { body, validationResult } = require('express-validator');

// // console.log(process.env.SECRET_KEY);

// // //  ajouter Geolocalisation
// // app.post("/geolocalisation", async (req, res) => {
// //   try {
    
// //     const {Adresse, Laltitude, Longitude} = req.body;

// //     const createdGeolocalisation = await prisma.geolocalisation.create({
// //       data: 
// //         { 
// //         Adresse : Adresse,
// //         Laltitude  : Laltitude,
// //         Longitude : Longitude,

// //         }
// //     });
// //     res.status(201).json({
// //       message: 'Geolocalisation créé avec succès',
// //       Geolocalisation: createdGeolocalisation
// //     });
// //   } catch (error) {
// //     console.error(error);
// //     res.status(500).json({ message: 'Erreur lors de la création du Geolocalisation'});
// //   }
// // });

// if (!process.env.SECRET_KEY) {
//   console.error("SECRET_KEY n'est pas défini dans les variables d'environnement");
//   process.exit(1);
// }

// // Validation middleware pour la  creation de l'utilisateur
// const validateUserCreation = [
//   body('prenom').notEmpty().withMessage('Prenom is required'),
//   body('nom').notEmpty().withMessage('Nom is required'),
//   body('email').isEmail().withMessage('Email is invalid'),
//   body('telephone').notEmpty().withMessage('Telephone is required'),
//   body('password').isLength({ min: 8 }).withMessage('Password must be at least 8 characters long'),
//   (req, res, next) => {
//     const errors = validationResult(req);
//     if (!errors.isEmpty()) {
//       return res.status(400).json({ errors: errors.array() });
//     }
//     next();
//   }
// ];


// // creation de compte
//  app.post("/user/create", validateUserCreation, async (req, res)=> {
//  const {prenom, nom, email, telephone, password} = req.body
//  try{
//   // Vérification si l'e-mail existe déjà dans la base de données
//  const existingUser = await prisma.utilisateur.findFirst({
//     where: { 
//       email: email
//      },
//  });
//   if (existingUser) {
//    return res.status(400).json({ message: "Cet email existe déjà" });
//    }
// console.log(prenom, nom, email, telephone, password)
//  const saltgen = bcrypt.genSaltSync(12)
//  const passwordHash = bcrypt.hashSync(password, saltgen)
//  // Création de l'utilisateur dans la base de données
//  const user = await prisma.utilisateur.create({
//   data: {
//    nom,
//    prenom,
//    email,
//   telephone,
//    password :passwordHash,
//   } 
//  })
//  const token = jwt.sign({ userId: user.id }, process.env.SECRET_KEY)
// return res.status(201).json({
//    message: "Utilisateur enregistré avec succès",
//   token,
//    user,
//  });
//  } catch (error) {
//  console.error("Error creating user:", error);
//  return res.status(500).json({ error: "Une erreur est survenue lors de la création de l'utilisateur" });
//  }
//  });



//   //  Route de connexion
// app.post("/login", async (req, res) => {
//    const { email, password } = req.body;
//     try{
//       const Utilisateur = await prisma.utilisateur.findFirst({
//         where: { 
//           email: email
//        }
//       });
//    console.log(Utilisateur);
//       if (!Utilisateur) {
//         return res.status(401).json({ message: "Identifiants incorrects" });
//      }
//      const isPasswordValid = await bcrypt.compare(password, Utilisateur.password);
//     if (!isPasswordValid) {
//      return res.status(401).json({ message: "Identifiants incorrects" });
//      }
  
//       const token = jwt.sign({ UtilisateurId: Utilisateur.id }, process.env.SECRET_KEY);
  
//     res.status(200).json({ message: "Connexion réussie", token });
//     } catch (error) {
//     console.error(error);
//     res.status(500).json({ message: "Erreur interne du serveur" });
//   }
//  });

//  // Authentication middleware
// const authenticateToken = (req, res, next) => {
//   const authHeader = req.headers['authorization'];
//   const token = authHeader && authHeader.split(' ')[1];

//   if (token == null) return res.sendStatus(401);

//   jwt.verify(token, process.env.SECRET_KEY, (err, user) => {
//     if (err) return res.sendStatus(403);
//     req.user = user;
//     next();
//   });
// };



const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const authRoutes = require('./routeAuthentification');
const userRoutes = require('./userRoutes');
const loginRouter = require('./loginRouter'); 
const authenticateToken = require('./authMiddleware');
const app = express();

dotenv.config();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());

const PORT = process.env.PORT || 3003;

// Routes d'authentification (Utilisation d'un seul chemin)
app.use('/auth', authRoutes);
app.use('/auth', loginRouter); // Monte le loginRouter sur '/auth'

// Routes protégées pour l'utilisateur
app.use(authenticateToken); // Utilise le middleware pour protéger les routes suivantes
app.use('/user', userRoutes); // Monte les routes utilisateur sur '/user'

// Routes protégées
app.use('/protected', authenticateToken, userRoutes);

// Route de test pour vérifier la protection des routes
app.get('/protected', authenticateToken, (req, res) => {
  res.json({ message: 'Protection de route', user: req.user });
});

// Routes page utilisateur
app.use('/userRoutes', userRoutes);

// Middleware de gestion des erreurs
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Erreur interne du serveur' });
});

app.listen(PORT, () => {
  console.log(`Serveur écoute sur le port ${PORT}`);
});