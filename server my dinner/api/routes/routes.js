'use strict';
const servicios = require('./../controllers/controllers.js');
module.exports = function(app) {

  // Servicios para crear y actualizar
  app.route('/nuevo_cliente')
    .put(servicios.insetarCliente)

  app.route('/nuevo_domicilio')
    .put(servicios.insetarDomicilio)

  app.route('/desactivar_cliente')
    .put(servicios.desactivarCliente)

  app.route('/desactivar_domicilio')
    .put(servicios.desactivarDomicilio)

  app.route('/actualizar_domicilio')
    .put(servicios.actualizarDomicilio)


  //Servicio para pedir una orden
  app.route('/ordenar')
    .put(servicios.crearOrden)

  // Servicio para consultar la cantidad de platillos vendidos por tipo de cocin que estén dentro un rango de fechas pasados como parámetros
  app.route('/reporte_periodo')
    .get(servicios.reportePeriodo)
};
