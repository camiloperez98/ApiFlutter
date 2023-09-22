import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_apis_proyect2/screen_views/cliente_input_form.dart';
import 'package:flutter_application_apis_proyect2/screen_views/clientes.dart';
import 'package:http/http.dart' as http;

Future<Client> createCliente(String nombre, String cedula, String email, String telefono, String estado) async {
  final response = await http.post(
    Uri.parse('https://proyectonodejsbackend.onrender.com/api/cliente'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "nombre": nombre,
      "cedula": cedula,
      "email": email,
      "telefono": telefono,
      "estado": estado,
    }),
  );

  if (response.statusCode == 201) {

    return Client.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}

class Client {
  final String id;
  final String nombre;
  final int cedula;
  final String email;
  final int telefono;
  final bool estado;

  const Client(
      {required this.id,
      required this.nombre,
      required this.cedula,
      required this.email,
      required this.telefono,
      required this.estado});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json["_id"],
      nombre: json["nombre"],
      cedula: json["cedula"],
      email: json["email"],
      telefono: json["telefono"],
      estado: json["estado"],
    );
  }
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _cedula = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _estado = TextEditingController();
  Future<Client>? _futureClient;

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
              const Text('CREAR CLIENTE', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ClienteInputForm(
                  controller: _nombre,
                  hintText: 'Ingrese el nombre',
                  labelText: 'Nombre del cliente',
                  helperText: '',
                  counterText: '',
                  prefixIcon: const Icon(Icons.arrow_right),
                  icon: const Icon(Icons.account_circle),
                  obscureText: false,),
              const SizedBox(height: 10),

              ClienteInputForm(
                  controller: _cedula,
                  hintText: 'Ingrese la cedula',
                  labelText: 'Cedula del cliente',
                  helperText: '',
                  counterText: '',
                  prefixIcon: const Icon(Icons.arrow_right),
                  icon: const Icon(Icons.badge_rounded  ),
                  obscureText: false,),
              const SizedBox(height: 10),

              ClienteInputForm(
                  controller: _email,
                  hintText: 'Ingrese el email',
                  labelText: 'Email del cliente',
                  helperText: '',
                  counterText: '',
                  prefixIcon: const Icon(Icons.arrow_right),
                  icon: const Icon(Icons.email_rounded),
                  obscureText: false,),
              const SizedBox(height: 10),

              ClienteInputForm(
                  controller: _telefono,
                  hintText: 'Ingrese el telefono',
                  labelText: 'Telefono del cliente',
                  helperText: '',
                  counterText: '',
                  prefixIcon: const Icon(Icons.arrow_right),
                  icon: const Icon(Icons.phone_callback_rounded), 
                  obscureText: false,),
              const SizedBox(height: 10),

              ClienteInputForm(
                  controller: _estado,
                  hintText: 'True(activo) - False(inactivo)',
                  labelText: 'Estado del cliente',
                  helperText: '',
                  counterText: '',
                  prefixIcon: const Icon(Icons.arrow_right),
                  icon: const Icon(Icons.toggle_on_outlined),
                  obscureText: false,),
              const SizedBox(height: 10),
             Row(
              children: [
                 ElevatedButton(
                onPressed: () {
                  Navigator.pop(
          context,
          MaterialPageRoute(builder: (context) =>const HomeCliente()),
          );
                  setState(() {
                    _futureClient = createCliente(
                    _nombre.text, 
                    _cedula.text,
                    _email.text, 
                    _telefono.text, 
                    _estado.text);
                  });
                },
                child: const Text('Crear cliente'),
              ),
              const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeCliente()),
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
