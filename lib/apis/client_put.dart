import 'package:flutter/material.dart';
import 'package:flutter_application_apis_proyect2/models/cliente_data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../screen_views/cliente_input_form.dart';
import '../screen_views/clientes.dart';

Future<Client> editCliente(
  String id,
  String nombre, 
  String cedula, 
  String email, 
  String telefono, 
  String estado,
  ) async {
  final response = await http.put(
    Uri.parse('https://proyectonodejsbackend.onrender.com/api/cliente'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "_id": id,
      "nombre": nombre,
      "cedula": int.parse(cedula),
      "email": email,
      "telefono": int.parse(telefono),
      "estado": estado
    }),
  );

  if (response.statusCode == 201) {
    return Client.fromJson(jsonDecode(response.body));
  } 
  else {
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

class EditCliente extends StatefulWidget {
  final Cliente client;
  const EditCliente({required this.client, Key? key}): super(key: key);

  @override
  State<EditCliente> createState() {
    return _EditClienteState();
  }
}

class _EditClienteState extends State<EditCliente> {
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _cedula = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _estado = TextEditingController();

  Future<Client>? _futureClient;

  @override
  void initState(){
    super.initState();
    _nombre.text = widget.client.nombre;
    _cedula.text = widget.client.cedula.toString();
    _email.text = widget.client.email;
    _telefono.text = widget.client.telefono.toString();
    _estado.text = widget.client.estado.toString();
  }

  Cliente? DataFromApi;

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
              const Text('EDITAR CLIENTE', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
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
                  Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>const HomeCliente()),
          );
                  setState(() {
                    _futureClient = editCliente(
                     widget.client.id,
                    _nombre.text, 
                    _cedula.text,
                    _email.text, 
                    _telefono.text, 
                    _estado.text);
                  });
                },
                child: const Text('Guardar Cambios'),
              ),
              const SizedBox(width: 10,),
               ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeCliente()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade700,
                          ),
                    child: const Text('Cancelar'),
                  )
              ],
             )
            ],
          ),
        ),
      ),
    );
  }
}