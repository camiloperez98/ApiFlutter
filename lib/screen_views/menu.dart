import 'package:flutter/material.dart';
import 'package:flutter_application_apis_proyect2/screen_views/clientes.dart';
import 'package:flutter_application_apis_proyect2/screen_views/ventas.dart';

class MenuProyecto extends StatefulWidget {
  const MenuProyecto({super.key});

  @override
  State<MenuProyecto> createState() => _MenuProyectoState();
}

class _MenuProyectoState extends State<MenuProyecto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VALISOFT', style: TextStyle(fontSize: 25)),
      ),
      body: Container(
        padding: const EdgeInsets.all(70),
        child: Column(
          children: [
              ListTile(
                  title: const Text('Clientes', style: TextStyle(fontSize: 18, color: Colors.black)),
                  onTap: () {
                     final route = MaterialPageRoute(builder: (context) =>const HomeCliente());
                    Navigator.push(context, route);
                  },
          ),
             ListTile(
                  title: const Text('Ventas', style: TextStyle(fontSize: 18, color: Colors.black)),
                  onTap: () {
                     final route = MaterialPageRoute(builder: (context) =>const HomeVenta());
                    Navigator.push(context, route);
                  },
          ),
          ],
        ),
      ),
    );
  }
}