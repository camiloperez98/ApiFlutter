import 'package:flutter/material.dart';
import 'package:flutter_application_apis_proyect2/screen_views/login.dart';
import 'package:http/http.dart' as http;
import '../loginNuevo.dart';
import '../models/alerta_data_model.dart';
import 'dart:convert';

class HomeAlerta extends StatefulWidget {
  const HomeAlerta({Key? key}) : super(key: key);

  @override
  State<HomeAlerta> createState() => _HomeAlertaState();
}

class _HomeAlertaState extends State<HomeAlerta> {
  bool _isLoading = true;
  List<Alerta> alertas = [];
  List<Alerta> resultados = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  DataModelAlerta? dataFromAPI;

  Future<void> _getData() async {
    try {
      String url = "https://project-valisoft-2559218.onrender.com/api/alertas";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        setState(() {
          dataFromAPI = DataModelAlerta.fromJson(json.decode(res.body));
          alertas = dataFromAPI!.alertas;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void searchAlerta(String query) {
    resultados.clear();
    if (query.isEmpty) {
      resultados.addAll(alertas);
    } else {
      resultados.addAll(alertas
          .where((alerta) => alerta.fechaAlerta.toString().contains(query)));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'ALERTAS',
                      style: TextStyle(
                        fontSize: 20,
                        // fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginViewComponent(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: const Text('Cerrar sesión'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Fecha alerta (Año-Mes-Dia)',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchAlerta(value);
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.teal.shade50),
                      columns: const [
                        DataColumn(
                          label: Text('Ente regulatorio',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        DataColumn(
                          label: Text('Fecha',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        DataColumn(
                          label: Text('Mensaje',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                      rows: resultados.map((alerta) {
                        return DataRow(cells: [
                          DataCell(Text(alerta.enteRegulatorio.toString())),
                          DataCell(Text(alerta.fechaAlerta.toString())),
                          DataCell(Text(alerta.mensajeAlerta.toString())),
                        ]);
                      }).toList(),
                    ) ,
                    )
                  ],
                ),
              ));
  }
}

