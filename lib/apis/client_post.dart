import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//https://frontendhbs.onrender.com/
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
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Client.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(response.body);
  }
}

class Client {
  final String id;
  final  String nombre;
  final  int cedula;
  final  String email;
  final  int telefono;
  final  bool estado;

  const Client({required this.id, required this.nombre, required this.cedula, required this.email, required this.telefono, required this.estado});

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


void main() {
  runApp(const MyApp());
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
    return MaterialApp(
      title: 'Crear Cliente',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Crear'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: (_futureClient == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _nombre,
          decoration: const InputDecoration(hintText: 'Digite Nombre'),
        ),
        const SizedBox(height: 20,),
        TextField(
          controller: _cedula,
          decoration: const InputDecoration(hintText: 'Digite cedula'),
        ),
        const SizedBox(height: 20,),
         TextField(
          controller: _email,
          decoration: const InputDecoration(hintText: 'Digite Email'),
        ),
        const SizedBox(height: 20,),
        TextField(
          controller: _telefono,
          decoration: const InputDecoration(hintText: 'Digite Teléfono'),
        ),
        const SizedBox(height: 20,),
          TextField(
          controller: _estado,
          decoration: const InputDecoration(hintText: 'Digite Estado'),
        ),
        const SizedBox(height: 20,),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureClient = createCliente(_nombre.text, _cedula.text, _email.text, _telefono.text, _estado.text);
            });
          },
          child: const Text('Crear cliente'),
        ),
      ],
    );
  }

  FutureBuilder<Client> buildFutureBuilder() {
    return FutureBuilder<Client>(
      future: _futureClient,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.nombre);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}