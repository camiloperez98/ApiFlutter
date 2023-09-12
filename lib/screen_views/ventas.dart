import 'package:flutter/material.dart';
import 'package:flutter_application_apis_proyect2/apis/venta_post.dart';
import 'package:flutter_application_apis_proyect2/apis/venta_put.dart';
import 'package:flutter_application_apis_proyect2/models/venta_data_model.dart';
import 'package:flutter_application_apis_proyect2/screen_views/login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeVenta extends StatefulWidget {
  const HomeVenta({Key? key}): super(key: key);

  @override
  State<HomeVenta> createState() => _HomeVentaState();
}

class _HomeVentaState extends State<HomeVenta> {
  bool _isLoading = true;
  List<Venta> ventas = [];
  List<Venta> resultados = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  DataModelVenta? dataFromAPI;
  Future<void> _getData() async {
    try {
      String url = "https://proyectonodejsbackend.onrender.com/api/venta";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        setState(() {
          dataFromAPI = DataModelVenta.fromJson(json.decode(res.body));
          ventas = dataFromAPI!.ventas;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void searchVenta(String query) {
    resultados.clear();
    if (query.isEmpty) {
      resultados.addAll(ventas);
    } else {
      resultados.addAll(ventas.where(
          (venta) => venta.numeroVenta.toString().contains(query)));
    }
    setState(() {});
  }

  void deleteVenta(String ventaId) async {
    try {
      final response = await http.delete(
        Uri.parse('https://proyectonodejsbackend.onrender.com/api/venta'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
         body: jsonEncode({"_id": ventaId})
      );
      if (response.statusCode == 200) {
        setState(() {
          _getData();
        });
      } else {
        throw Exception('Error al eliminar la venta');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        const Text('VENTAS',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 30),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PostVenta(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade400,
                          ),
                          child: const SizedBox(
                            width: 120,
                            child: Center(
                              child: Text('Agregar Venta'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30,),
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
                  ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Número de venta',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchVenta(value);
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.teal.shade50),
                      columns: const [
                        DataColumn(
                          label: Text('No. Venta',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text('Nombre cliente',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text('Subtotal',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text('Iva',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text('Estado',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text('Fecha',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text('Total Venta',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text('Acciones',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                      rows: resultados.map((venta) {
                        return DataRow(cells: [
                          DataCell(Text(venta.numeroVenta.toString())),
                          DataCell(Text(venta.nombreCliente.toString())),
                          DataCell(Text(venta.subtotal.toString())),
                          DataCell(Text(venta.iva.toString())),
                          DataCell(
                              Text(venta.estado ? 'Activo' : 'Inactivo')),
                          DataCell(Text(venta.fecha.toString())),
                          DataCell(Text(venta.total.toString())),
                          DataCell(Row(
                            children: [ IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditVenta(vent: venta),
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
                                  deleteVenta(venta.id);
                                  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const HomeVenta(),
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
                ),
              ),
            ),
    );
  }
}


// class HomeVenta extends StatefulWidget {
//   const HomeVenta({super.key});

//   @override
//   State<HomeVenta> createState() => _HomeVentaState();
// }

// class _HomeVentaState extends State<HomeVenta> {
//   bool _isLoading = true;
//   List<Venta> ventas = [];
//   List<Venta> resultados = [];
//   TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _getData();
//   }

//   DataModelVenta? dataFromAPI;
//   _getData() async {
//     try {
//       String url = "https://proyectonodejsbackend.onrender.com/api/venta";
//       http.Response res = await http.get(Uri.parse(url));
//       if (res.statusCode == 200) {
//         dataFromAPI = DataModelVenta.fromJson(json.decode(res.body));
//         ventas = dataFromAPI!.ventas;
//         _isLoading = false;
//         //setState(() {});
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   void searchVenta(String query) {
//     resultados.clear();
//     if (query.isEmpty) {
//       resultados.addAll(ventas);
//     } else {
//       resultados.addAll(ventas.where(
//           (venta) => venta.numeroVenta == int.parse(query)));
//     }
//     setState(() {});
//   }

//   void deleteVenta(String ventaId) async {
//     try {
//       final response = await http.delete(
//           Uri.parse('https://proyectonodejsbackend.onrender.com/api/venta'),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//           body: jsonEncode({"_id": ventaId}));
//       if (response.statusCode == 200) {
//         setState(() {
//           _getData();
//         });
//       } else {
//         throw Exception('Error al eliminar la venta');
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // appBar: AppBar(
//         //   title: const Text("Clientes"),
//         // ),
//         body: _isLoading
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         const SizedBox(height: 20),
//                         Row(
//                           children: [
//                             const Text('VENTAS',
//                                 style: TextStyle(
//                                     fontSize: 30, fontWeight: FontWeight.bold)),
//                             const SizedBox(width: 30),
//                             ElevatedButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const PostVenta()),
//                                 );
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.blue.shade400,
//                               ),
//                               child: const SizedBox(
//                                 width: 120,
//                                 child: Center(
//                                   child: Text('Agregar Venta'),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         //const SizedBox(height: 10),
//                         const SizedBox(height: 10),
//                         DataTable(
//                           headingRowColor: MaterialStateColor.resolveWith(
//                               (states) => Colors.teal.shade50),
//                           columns: const [
//                             DataColumn(
//                                 label: Text('No. Venta',
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold))),
//                             DataColumn(
//                                 label: Text('Nombre cliente',
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold))),
//                             DataColumn(
//                                 label: Text('Subtotal',
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold))),
//                             DataColumn(
//                                 label: Text('Iva',
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold))),
//                             DataColumn(
//                                 label: Text('Estado',
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold))),
//                             DataColumn(
//                                 label: Text('Fecha',
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold))),
//                             DataColumn(
//                                 label: Text('Total Venta',
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold))),
//                             DataColumn(
//                                 label: Text('Acciones',
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold))),
//                           ],
//                           rows: ventas.map((venta) {
//                             return DataRow(cells: [
//                               DataCell(Text(venta.numeroVenta.toString())),
//                               DataCell(Text(venta.nombreCliente.toString())),
//                               DataCell(Text(venta.subtotal.toString())),
//                               DataCell(Text(venta.iva.toString())),
//                               DataCell(
//                                   Text(venta.estado ? 'Activo' : 'Inactivo')),
//                               DataCell(Text(venta.fecha.toString())),
//                               DataCell(Text(venta.total.toString())),
//                               DataCell(Row(
//                                 children: [
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       deleteVenta(venta.id);
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               const HomeVenta(),
//                                         ),
//                                       );
//                                     },
//                                     icon: const Icon(Icons.delete),
//                                   )
//                                 ],
//                               )),
//                             ]);
//                           }).toList(),
//                         ),
//                         const SizedBox(
//                           height: 15,
//                         ),
//                       ],
//                     ))));
//   }
// }
