const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { body, validationResult } = require('express-validator');
const authenticateToken = require('./authMiddleware'); 
// const prisma = require('../prisma/prisma')
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const dotenv = require("dotenv");
dotenv.config();

const router = express.Router();
const validateUserCreation = [
  body('prenom').notEmpty().withMessage('Prenom is required'),
  body('nom').notEmpty().withMessage('Nom is required'),
  body('email').isEmail().withMessage('Email is invalid'),
  body('telephone').notEmpty().withMessage('Telephone is required'),
  body('password').isLength({ min: 8 }).withMessage('Password must be at least 8 characters long'),
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    next();
  }
];

// cretion de compte
router.post("/user/create", validateUserCreation, async (req, res) => {
  const { prenom, nom, email, telephone, password } = req.body;
  try {
    const existingUser = await prisma.utilisateur.findFirst({
      where: { email },
    });
    if (existingUser) {
      return res.status(400).json({ message: "Cet email existe déjà" });
    }

    const saltgen = bcrypt.genSaltSync(12);
    const passwordHash = bcrypt.hashSync(password, saltgen);

    const user = await prisma.utilisateur.create({
      data: { prenom, nom, email, telephone, password: passwordHash },
    });
    // const token = jwt.sign({ UtilisateurId: Utilisateur.id }, process.env.SECRET_KEY);
     const token = jwt.sign({ UtilisteurId: user.id }, process.env.SECRET_KEY);
    console.log("Token généré:", token); 
    return res.status(201).json({ message: "Utilisateur enregistré avec succès", token, user });
   } catch (error) {
    console.error("Error creating user:", error);
    return res.status(500).json({ error: "Une erreur est survenue lors de la création de l'utilisateur" });
  }
});

  module.exports = router;
  