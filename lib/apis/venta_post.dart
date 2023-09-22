import 'package:flutter/material.dart';
import 'package:flutter_application_apis_proyect2/screen_views/ventas.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../screen_views/cliente_input_form.dart';


Future<Vent> createVenta(String numeroVenta, String nombreCliente, String subtotal, String iva, String estado, String fecha, String total) async {
  final response = await http.post(
    Uri.parse('https://proyectonodejsbackend.onrender.com/api/venta'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "numeroVenta": numeroVenta,
      "nombreCliente": nombreCliente,
      "subtotal": subtotal,
      "iva": iva,
      "estado": estado,
      "fecha": fecha,
      "total": total
    }),
  );

  if (response.statusCode == 201) {

    return Vent.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}

class Vent {
  final String id;
  final int numeroVenta;
  final String nombreCliente;
  final int subtotal;
  final int iva;
  final bool estado;
  final String fecha;
  final int total;

  const Vent(
      {required this.id,
      required this.numeroVenta,
      required this.nombreCliente,
      required this.subtotal,
      required this.iva,
      required this.estado,
      required this.fecha,
      required this.total
      });

  factory Vent.fromJson(Map<String, dynamic> json) {
    return Vent(
      id: json["_id"],
      numeroVenta: json["numeroVenta"],
      nombreCliente: json["nombreCliente"],
      subtotal: json["subtotal"],
      iva: json["iva"],
      estado: json["estado"],
      fecha: json["fecha"],
      total: json["total"]
    );
  }
}

class PostVenta extends StatefulWidget {
  const PostVenta({super.key});

  @override
  State<PostVenta> createState(){
    return _PostVentaState();
  }  
}

class _PostVentaState extends State<PostVenta> {
  final TextEditingController _numeroVenta = TextEditingController();
  final TextEditingController _nombreCliente = TextEditingController();
  final TextEditingController _subtotal = TextEditingController();
  final TextEditingController _iva = TextEditingController();
  final TextEditingController _estado = TextEditingController();
  final TextEditingController _fecha = TextEditingController();
  final TextEditingController _total = TextEditingController();
  Future<Vent>? _futureVent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.1,
            horizontal: MediaQuery.of(context).size.height * 0.1
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             const Text('CREAR VENTA', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ClienteInputForm(
                  controller: _numeroVenta,
                  hintText: 'Ingrese el numero de la venta',
                  labelText: 'No. de venta',
                  helperText: '',
                  counterText: '',
                  prefixIcon: const Icon(Icons.arrow_right),
                  icon: const Icon(Icons.money),
                  obscureText: false,),
              const SizedBox(height: 10),

              ClienteInputForm(
                  controller: _nombreCliente,
                  hintText: 'Ingrese el nombre del cliente',
                  labelText: 'Nombre del cliente',
                  helperText: '',
                  counterText: '',
                  prefixIcon: const Icon(Icons.arrow_right),
                  icon: const Icon(Icons.account_circle_sharp),
                  obscureText: false,),
              const SizedBox(height: 10),

              ClienteInputForm(
                  controller: _subtotal,
                  hintText: 'Ingrese el subtotal',
                  labelText: 'Subtotal',
                  helperText: '',
                  counterText: '',
                  prefixIcon: const Icon(Icons.arrow_right),
                  icon: const Icon(Icons.monetization_on_outlined),
                  obscureText: false,),
              const SizedBox(height: 10),

              ClienteInputForm(
                  controller: _iva,
                  hintText: 'Ingrese el porcentaje del iva',
                  labelText: 'Iva',
                  helperText: '',
                  counterText: '',
                  prefixIcon: const Icon(Icons.arrow_right),
                  icon: const Icon(Icons.percent),
                  obscureText: false,),
              const SizedBox(height: 10),
              ClienteInputForm(
                  controller: _estado,
                  hintText: 'True(activo) - False(inactivo)',
                  labelText: 'Estado de la venta',
                  helperText: '',
                  counterText: '',
                  prefixIcon: const Icon(Icons.arrow_right),
                  icon: const Icon(Icons.toggle_on_outlined),
                  obscureText: false,),
              const SizedBox(height: 10),
              ClienteInputForm(
                  controller: _fecha,
                  hintText: 'Ingrese la fecha',
                  labelText: 'fecha de la venta',
                  helperText: '',
                  counterText: '',
                  prefixIcon: const Icon(Icons.arrow_right),
                  icon: const Icon(Icons.date_range),
                  obscureText: false,),
              const SizedBox(height: 10),
              ClienteInputForm(
                  controller: _total,
                  hintText: 'Ingrese el total de la venta',
                  labelText: 'Total de la venta',
                  helperText: '',
                  counterText: '',
                  prefixIcon: const Icon(Icons.arrow_right),
                  icon: const Icon(Icons.monetization_on),
                  obscureText: false,),
              const SizedBox(height: 10),
              Row(
                children: [
                      ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>const HomeVenta()),
          );
                  setState(() {
                    _futureVent = createVenta(
                    _numeroVenta.text, 
                    _nombreCliente.text,
                    _subtotal.text, 
                    _iva.text,
                    _estado.text,
                    _fecha.text,
                    _total.text
                    );
                  });
                },
                child: const Text('Crear Venta'),
              ),
              const SizedBox(width: 10),
               ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeVenta()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade700,
                          ),
                    child: const Text('Cancelar'),
                  ),
                ],
              )
          ],
        ),
        ),
      ),
    );
  }
}