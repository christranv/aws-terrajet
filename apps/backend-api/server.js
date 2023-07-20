"use strict";

const express = require("express");

// Constants
const HOST = "0.0.0.0";
const PORT = 80;

// App
const app = express();
app.get("/", (req, res) => {
  res.send("TerraJet Sample API");
});

app.listen(PORT, HOST, () => {
  console.log(`Running on http://${HOST}:${PORT}`);
});
