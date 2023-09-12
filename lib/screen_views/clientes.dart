import 'package:flutter/material.dart';
import 'package:flutter_application_apis_proyect2/apis/client_post.dart';
import 'package:flutter_application_apis_proyect2/apis/client_put.dart';
import 'package:flutter_application_apis_proyect2/models/cliente_data_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'login.dart';

class HomeCliente extends StatefulWidget {
  const HomeCliente({Key? key}) : super(key: key);

  @override
  State<HomeCliente> createState() => _HomeClienteState();
}

class _HomeClienteState extends State<HomeCliente> {
  bool _isLoading = true;
  List<Cliente> clientes = [];
  List<Cliente> resultados = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  DataModelCliente? dataFromAPI;
  _getData() async {
    //Future<DataModelCliente> _getData() async {
    try {
      String url = "https://proyectonodejsbackend.onrender.com/api/cliente";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        setState(() {
          dataFromAPI = DataModelCliente.fromJson(json.decode(res.body));
          clientes = dataFromAPI!.clientes;
          _isLoading = false;
          //setState(() {});
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void searchCliente(String query) {
    resultados.clear();
    if (query.isEmpty) {
      resultados.addAll(clientes);
    } else {
      resultados.addAll(clientes.where((cliente) =>
          cliente.nombre.toLowerCase().contains(query.toLowerCase())));
    }
    setState(() {});
  }

  void deleteCliente(String clienteId) async {
    try {
      final response = await http.delete(
          Uri.parse('https://proyectonodejsbackend.onrender.com/api/cliente'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"_id": clienteId}));
      if (response.statusCode == 200) {
        setState(() {
          _getData();
        });
      } else {
        throw Exception('Error al eliminar el cliente');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text("Clientes"),
        // ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text('CLIENTES',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 30),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyApp()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade400,
                              ),
                              child: const SizedBox(
                                width: 120,
                                child: Center(
                                  child: Text('Agregar Cliente'),
                                ),
                              ),
                            ),
                            const SizedBox(width: 30),
                                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                    child: const Text('Cerrar sesión'),
                  )
                            //     IconButton(
                            //   onPressed: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => const MyApp()));
                            //   },
                            //   icon: const Icon(Icons.add_circle),
                            //   iconSize: 30,
                            // ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: 'Nombre del cliente',
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            setState(() {
                              searchCliente(value);
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        DataTable(
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.teal.shade50),
                          columns: const [
                            DataColumn(
                                label: Text('Nombre',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Cedula',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Email',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Telefono',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Estado',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Acciones',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                          ],
                          rows: resultados.map((cliente) {
                            return DataRow(cells: [
                              DataCell(Text(cliente.nombre.toString())),
                              DataCell(Text(cliente.cedula.toString())),
                              DataCell(Text(cliente.email.toString())),
                              DataCell(Text(cliente.telefono.toString())),
                              DataCell(
                                  Text(cliente.estado ? 'Activo' : 'Inactivo')),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditCliente(client: cliente),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.create_rounded),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      deleteCliente(cliente.id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const HomeCliente(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              )),
                            ]);
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ))));
  }
}
