'use strict';

const mysql = require('./../mysql/interfaz.js');
var connection = mysql.conectarBaseDatos()

Date.prototype.today = function () {
    return this.getFullYear() + "/" +
    (((this.getMonth()+1) < 10)?"0":"") + (this.getMonth()+1) + "/" +
    ((this.getDate() < 10)?"0":"") + this.getDate();
},

Date.prototype.timeNow = function () {
     return ((this.getHours() < 10)?"0":"") + this.getHours() + ":" +
     ((this.getMinutes() < 10)?"0":"") + this.getMinutes() + ":" +
     ((this.getSeconds() < 10)?"0":"") + this.getSeconds();
},

exports.reportePeriodo = async function(req, res) {
  const fechaInicioPeriodo = req.body.inicio;
  const fechaFinPeriodo = req.body.fin;

  var respuesta = {
    periodo:{
      inicio:fechaInicioPeriodo,
      fin: fechaInicioPeriodo
    },
    platillos:{
      vendidos:{
        cocina:{
          Mexicana:0,
          Italiana:0,
          Japonesa:0
        }
      }
    }
  }

  let result = await new Promise(function(resolve) {
    const query = `SELECT * FROM dinner.resumen_platillos_vendidos WHERE DATE(fecha) >= '${fechaInicioPeriodo}' AND DATE(fecha) <= '${fechaFinPeriodo}';`
    connection.query(query, function (error, results) {
      if (error) console.error(error);
      resolve(results)
    });
  });

  if(result){
    let cocina = respuesta.platillos.vendidos.cocina
    cocina.Mexicana = result.filter(i=>i.tipo_cocina==1).map(i=>i.cantidad).reduce((total, num)=> total+=num,0)
    cocina.Italiana = result.filter(i=>i.tipo_cocina==2).map(i=>i.cantidad).reduce((total, num)=> total+=num,0)
    cocina.Japonesa = result.filter(i=>i.tipo_cocina==3).map(i=>i.cantidad).reduce((total, num)=> total+=num,0)
  }

   res.send(respuesta);
};

exports.crearOrden = async function(req, res) {
  const orden = req.body.orden;
  /*
    var orden = {
      cliente:{
        idCliente:0,
        email:'email',
        nombre: 'nombre',
        idDireccion: 0,
        direccion:{
          calle:'',
          numero:'',
          numero_interior:'',
          codigo_postal:0,
          colonia:'',
          municipio:'',
          estado:'',
          pais:'',
          entre_calle_1:'',
          entre_calle_2:'',
          descripcion:''
        }
      },
      orden:[
        {
          idPlatillo:0,
          cantidad:0,
          precio:0,
          indicaciones:''
        }
      ],
      pago:{
        monto:0,
        metodoDePago:0,
        propina:0,
        descuento:0
      }
    }
  */
  if(!orden)return res.send({estatus:404, mensaje:'no hay informacion de la orden'});

  if(orden.orden.length <= 1) return res.send({estatus:412, mensaje:'insuficientes platillos para completar el pedido'});


  if(!orden.cliente.idCliente){
    let result = await new Promise(function(resolve) {
      const query = `SELECT id FROM cliente WHERE email = '${orden.cliente.email}' LIMIT 1;`
      connection.query(query, function (error, results) {
        if (error) console.error(error);
        resolve(results)
      });
    });

    if(!result[0].id)return res.send({estatus:410, mensaje:'email no valido'});
    orden.cliente.idCliente= result[0].id
  }

  if(!orden.cliente.idDireccion){
    let result = await new Promise(function(resolve) {
      const query = `CALL insertar_domicilio (
        ${orden.cliente.idCliente},
        '${oeden.cliente.direccion.calle}',
        '${oeden.cliente.direccion.numero}',
        '${oeden.cliente.direccion.numero_interior}',
        ${oeden.cliente.direccion.codigo_postal},
        '${oeden.cliente.direccion.colonia}',
        '${oeden.cliente.direccion.municipio}',
        '${oeden.cliente.direccion.estado}',
        '${oeden.cliente.direccion.pais}',
        '${oeden.cliente.direccion.entre_calle_1}',
        '${oeden.cliente.direccion.entre_calle_2}',
        '${oeden.cliente.direccion.descripcion}');`
      connection.query(query, function (error, results) {
        if (error) console.error(error);
        resolve(results)
      });
    });

    if(result[0].id)orden.cliente.idDireccion = result[0].id
    else orden.cliente.idDireccion=0
  }

  const fechaPedido =  new Date().today() + ' ' + new Date().timeNow();

  await new Promise(function(resolve) {
    const query = `UPDATE clientes SET fecha_ultimo_pedido = '${fechaPedido}', id_ultimo_domicilio = '${orden.cliente.idDireccion}' WHERE id = '${orden.cliente.idCliente}';`
    connection.query(query, function (error) {
      if (error) console.error(error);
      resolve()
    });
  });

  const idOrden = await new Promise(function(resolve) {
    const query = `call insertar_orden(
      ${orden.cliente.idCliente},
      ${orden.cliente.idDireccion},
      '${fechaPedido}',
      ${orden.pago.monto},
      ${orden.pago.metodoDePago},
      ${orden.pago.descuento},
      ${orden.pago.propina});`
    connection.query(query, function (error, results) {
      if (error) console.error(error);
      resolve(results[0][0].id)
    });
  });

  if(!idOrden) return res.send({estatus:411, mensaje:'problema con el servidor intentar mas tarde'});

  for (var i = 0; i < orden.orden.length; i++) {
    let platillo = orden.orden[i]
    const subtotal = (parseInt(platillo.cantidad) * parseInt( parseFloat(platillo.precio) * 100) ) / 100;
    var query = `INSERT INTO lista_orden (id_orden, id_platillo, cantidad, precio_unitario, subtotal, indicaciones) VALUES (
      ${idOrden},
      ${platillo.idPlatillo},
      ${platillo.cantidad},
      ${platillo.precio},
      ${subtotal},
      '${platillo.indicaciones}'
    );`

    await new Promise(function(resolve) {
      connection.query(query, function (error, results,filas) {
        if (error) console.error(error);
        resolve()
      });
    });
  }

  res.send({estatus:200, idOrden:idOrden, mensaje:'orden creada'});
};

exports.insetarDomicilio = async function(req, res) {
  const domicilio = req.body.domicilio;
  /*
    var domicilio = {
      cliente:{
        idCliente:0,
        email:'email',
        nombre: 'nombre',
      },
      direccion:{
        calle:'',
        numero:'',
        numero_interior:'',
        codigo_postal:0,
        colonia:'',
        municipio:'',
        estado:'',
        pais:'',
        entre_calle_1:'',
        entre_calle_2:'',
        descripcion:''
      }
    }
  */

  if(!domicilio)return res.send({estatus:404, mensaje:'no hay informacion de la dirección'});

  if(!domicilio.cliente.idCliente){
    let result = await new Promise(function(resolve) {
      const query = `SELECT id FROM cliente WHERE email = '${domicilio.cliente.email}' LIMIT 1;`
      connection.query(query, function (error, results) {
        if (error) console.error(error);
        resolve(results)
      });
    });

    if(!result[0].id)return res.send({estatus:410, mensaje:'email no valido'});
    orden.cliente.idCliente= result[0].id
  }


  let result = await new Promise(function(resolve) {
    const query = `CALL insertar_domicilio (
      ${domicilio.cliente.idCliente},
      '${domicilio.direccion.calle}',
      '${domicilio.direccion.numero}',
      '${domicilio.direccion.numero_interior}',
      ${domicilio.direccion.codigo_postal},
      '${domicilio.direccion.colonia}',
      '${domicilio.direccion.municipio}',
      '${domicilio.direccion.estado}',
      '${domicilio.direccion.pais}',
      '${domicilio.direccion.entre_calle_1}',
      '${domicilio.direccion.entre_calle_2}',
      '${domicilio.direccion.descripcion}');`
    connection.query(query, function (error, results) {
      if (error) console.error(error);
      resolve(results)
    });
  });

  if(!result[0][0].id)return  res.send({estatus:411, mensaje:'problema con el servidor intentar mas tarde'});

  res.send({estatus:200, idDireccion:result[0][0].id, mensaje:'direccion creada'});
}

exports.insetarCliente = async function(req, res) {
  const cliente = req.body.cliente;
  /*
    var cliente = {
      email:'email',
      nombre: 'nombre',
      telefono:0 ,
      whatsapp:0,
    }
  */

  if(!cliente)return res.send({estatus:404, mensaje:'no hay informacion del cliente'});

  const fechaCreacion = new Date().today() + ' ' + new Date().timeNow();

  if(!cliente.whatsapp) cliente.whatsapp = 0;
  else cliente.whatsapp = 1

  let result = await new Promise(function(resolve) {
    const query = `CALL insertar_cliente (
      '${cliente.email}',
      '${cliente.nombre}',
      ${cliente.telefono},
      ${cliente.whatsapp},
      '${fechaCreacion}');`
    connection.query(query, function (error, results) {
      if (error) console.error(error);
      resolve(results)
    });
  });

  if(!result[0][0].id)return  res.send({estatus:411, mensaje:'problema con el servidor intentar mas tarde'});

  res.send({estatus:200, idCliente:result[0][0].id, mensaje:'cliente creado'});
}

exports.desactivarCliente = async function(req, res) {
  const idClient = req.body.cliente.idClient;
  /*
    var cliente = {
      idClient:0
    }
  */

  if(!idClient)return res.send({estatus:404, mensaje:'no hay informacion del cliente'});

  let result = await new Promise(function(resolve) {
    const query = `UPDATE clientes SET estatus = '0' WHERE (id = ${idClient});`
    connection.query(query, function (error, results,filas) {
      if (error) console.error(error);
      resolve(results)
    });
  });

  res.send({estatus:200, mensaje:'cliente dado de baja'});
}

exports.desactivarDomicilio = async function(req, res) {
  const idClient = req.body.cliente.idClient;
  const idDomicilio = req.body.cliente.direccion.idDomicilio;
  /*
    var cliente = {
      idClient:0,
      direccion:{
        idDomicilio:0
      }
    }
  */

  if(!idClient)return res.send({estatus:404, mensaje:'no hay informacion del cliente'});
  if(!idDomicilio)return res.send({estatus:404, mensaje:'no hay informacion del domicilio'});

  let result = await new Promise(function(resolve) {
    const query = `UPDATE domicilios SET estatus = '0' WHERE (id = ${idDomicilio} AND id_cliente = ${idClient});`
    connection.query(query, function (error, results,filas) {
      if (error) console.error(error);
      resolve(results)
    });
  });

  res.send({estatus:200, mensaje:'domicilio dado de baja'});
}

exports.actualizarDomicilio = async function(req, res) {
  const idClient = req.body.domicilio.cliente.idClient;
  const idDomicilio = req.body.domicilio.cliente.direccion.idDomicilio;
  const direccion =  req.body.domicilio.direccion
  /*
    var domicilio = {
      cliente:{
        idCliente:0,
      },
      direccion:{
        idDireccion:0,
        calle:'',
        numero:'',
        numero_interior:'',
        codigo_postal:0,
        colonia:'',
        municipio:'',
        estado:'',
        pais:'',
        entre_calle_1:'',
        entre_calle_2:'',
        descripcion:''
      }
    }
  */

  if(!idClient)return res.send({estatus:404, mensaje:'no hay informacion del cliente'});
  if(!idDomicilio)return res.send({estatus:404, mensaje:'no hay informacion del domicilio'});

  var update = '';
  if(direccion.calle) update += `calle = '${direccion.calle}', `
  if(direccion.numero) update += `numero = '${direccion.numero}', `
  if(direccion.numero_interior) update += `numero_interior = '${direccion.numero_interior}', `
  if(direccion.codigo_postal) update += `codigo_postal = '${direccion.codigo_postal}', `
  if(direccion.colonia) update += `colonia = '${direccion.colonia}', `
  if(direccion.municipio) update += `municipio = '${direccion.municipio}', `
  if(direccion.pais) update += `pais = '${direccion.pais}', `
  if(direccion.entre_calle_1) update += `entre_calle_1 = '${direccion.entre_calle_1}', `
  if(direccion.entre_calle_2) update += `entre_calle_2 = '${direccion.entre_calle_2}', `
  if(direccion.descripcion) update += `descripcion = '${direccion.descripcion}', `

  if(update.length==0) return res.send({estatus:404, mensaje:'no hay informacion para actualizar'});
  update = update.substr(0, update.lastIndexOf(','))

  let result = await new Promise(function(resolve) {
    const query = `UPDATE domicilios SET ${update} WHERE (id = ${idDomicilio} AND id_cliente = ${idClient});`
    connection.query(query, function (error, results,filas) {
      if (error) console.error(error);
      resolve(results)
    });
  });

  //if(!result[0].id)return  res.send({estatus:411, mensaje:'problema con el servidor intentar mas tarde'});

  res.send({estatus:200, mensaje:'direccion actualizada'});
}
