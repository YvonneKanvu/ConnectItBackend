const express = require('express');
const router = express.Router();
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const authenticateToken = require('./authMiddleware'); 

// Route protégée pour obtenir les données utilisateur
router.get("/userPage", authenticateToken, async (req, res) => {
  try {
    console.log('Requête reçue pour /userPage');
    console.log('Données utilisateur dans req.user:', req.user);
    const Utilisateur = await prisma.utilisateur.findFirst({
      where: { id: req.user.userId },
    });
    if (!Utilisateur) {
      console.log('Utilisateur non trouvé');
      return res.status(404).json({ message: "Utilisateur non trouvé" });
    }                                               
    console.log('Utilisateur trouvé :', Utilisateur);
    res.status(200).json(Utilisateur);
  } catch (error) {
    console.error('Erreur lors de la récupération des données utilisateur:', error);
    res.status(500).json({ message: "Erreur interne du serveur" });
  }
});

module.exports = router;
