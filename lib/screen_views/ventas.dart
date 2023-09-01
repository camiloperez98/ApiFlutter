import 'package:flutter/material.dart';
import 'package:flutter_application_apis_proyect2/models/venta_data_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class HomeVenta extends StatefulWidget {
  const HomeVenta({super.key});

  @override
  State<HomeVenta> createState() => _HomeVentaState();
}

class _HomeVentaState extends State<HomeVenta> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  DataModelVenta? dataFromAPI;
  _getData() async {
    try {
      String url = "https://proyectonodejsbackend.onrender.com/api/venta";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        dataFromAPI = DataModelVenta.fromJson(json.decode(res.body));
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
        title: const Text("Ventas"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(dataFromAPI!.ventas[index].numeroVenta.toString()),
                      Text(dataFromAPI!.ventas[index].nombreCliente.toString()),
                      Text(dataFromAPI!.ventas[index].subtotal.toString()),
                      Text(dataFromAPI!.ventas[index].iva.toString()),
                      Text(dataFromAPI!.ventas[index].estado.toString()),
                      Text(dataFromAPI!.ventas[index].fecha.toString()),
                      Text(dataFromAPI!.ventas[index].total.toString()),
                      
                    ],
                  ),
                );
              },
              itemCount: dataFromAPI!.ventas.length,
            ),
    );
  }
}