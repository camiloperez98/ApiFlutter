import 'package:flutter/material.dart';
import 'package:flutter_application_apis_proyect2/apis/client_post.dart';
import 'package:flutter_application_apis_proyect2/apis/client_put.dart';
import 'package:flutter_application_apis_proyect2/models/cliente_data_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeCliente extends StatefulWidget {
  const HomeCliente({super.key});

  @override
  State<HomeCliente> createState() => _HomeClienteState();
}

class _HomeClienteState extends State<HomeCliente> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  DataModelCliente? dataFromAPI;
  _getData() async {
    try {
      String url = "https://proyectonodejsbackend.onrender.com/api/cliente";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        dataFromAPI = DataModelCliente.fromJson(json.decode(res.body));
        _isLoading = false;
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clientes"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
            children: [
            Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(dataFromAPI!.clientes[index].nombre.toString()),
                      Text(dataFromAPI!.clientes[index].cedula.toString()),
                      Text(dataFromAPI!.clientes[index].email.toString()),
                      Text(dataFromAPI!.clientes[index].telefono.toString()),
                      if (dataFromAPI!.clientes[index].estado == true)
                        const Text('Activo')
                      else
                        const Text('Inactivo')
                    ],
                  ),
                );
              },
              itemCount: dataFromAPI!.clientes.length,
            ),
            ),

  ElevatedButton(
      onPressed: () {
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyAppEditCliente()),
          );
      },
      child: const SizedBox(
        width: 110,
        child: Center(
          child: Text('Editar Cliente'),
        ),
        ),
    ),
    const SizedBox(height: 15),
      ElevatedButton(
      onPressed: () {
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
          );
      },
      child: const SizedBox(
        width: 110,
        child: Center(
          child: Text('Crear Cliente'),
        ),
        ),
    ),
        const SizedBox(height: 150),

              ],
            ),
    );
  }
}
