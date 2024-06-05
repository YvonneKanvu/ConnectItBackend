const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");
dotenv.config();

const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  console.log("Authorization Header:", authHeader); 
  const token = authHeader && authHeader.split(" ")[1];
  console.log("Extracted Token:", token); 
  if (!token) { 
    console.log("Token JWT non fourni");
    return res.sendStatus(401);
  }
  jwt.verify(token, process.env.SECRET_KEY, (err, user) => {
    if (err) {
      console.log("Token JWT invalide");
      return res.sendStatus(403);
    }
    console.log("Token JWT vérifié, utilisateur :", user);
    // req.user = user;
    req.user = { userId: user.UtilisateurId }; 
    next();
  });
};

module.exports = authenticateToken;