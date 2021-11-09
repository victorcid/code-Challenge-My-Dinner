const express = require('express'),
      port = process.env.PORT || 3000,
      bodyParser = require('body-parser');



var  app = express();
var rutas = require('./api/routes/routes.js');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

rutas(app); //manejo de las rutas del servicio
app.listen(port);


console.log('My Dinner REST API service runing on port: ' + port);
