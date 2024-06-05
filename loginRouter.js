const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const router = express.Router();

router.post("/login", async (req, res) => {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).json({ message: "Email et mot de passe requis" });
    }
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
 module.exports = router;
