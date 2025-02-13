'use strict';

require('dotenv').config()
const express = require('express');
const os = require('os');

// Constants
const PORT = process.env.APP_PORT;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
  res.send(
    `<body style='background-color:#283E5B'><h1 style='color: orange;text-align:center'>${process.env.SECRET_MESSAGE} - ${os.hostname()}\n🙈️️️️️️</h1></body>`
  );
});

app.listen(PORT, HOST);
console.log(`Running with message: ${process.env.SECRET_MESSAGE}`);
console.log(`Running on http://${HOST}:${PORT}`);