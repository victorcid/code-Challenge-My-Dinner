'use strict';

var mysql = require('mysql');
var opciones = {
  host     : 'localhost',
  user     : 'root',
  password : '123',
  database : 'dinner'
}

var connection


exports.conectarBaseDatos = function() {
  if (connection) connection.end();
  connection = mysql.createConnection(opciones);
  connection.connect();
  return connection;
}

exports.desconectar = function() {
  if (connection) connection.end();
  connection=undefined
}
