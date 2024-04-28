const express = require("express");
const PORT = 3000;

const app = express();
app.use(express.json());

//console sur le navigateur
app.get("/", (req, res) => {
    res.send("L'application fonctionne")
  });

// liste 
app.get("/",(req, res) => {
    res.send(data)
});
app.listen(PORT,() => {
    console.log(`le Serveur ecoute sur le port ${PORT}`)
})



