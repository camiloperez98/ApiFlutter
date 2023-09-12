import 'package:flutter/material.dart';
import 'package:flutter_application_apis_proyect2/screen_views/clientes.dart';
import 'package:flutter_application_apis_proyect2/screen_views/home.dart';
import 'package:flutter_application_apis_proyect2/screen_views/login.dart';
import 'package:flutter_application_apis_proyect2/screen_views/ventas.dart';

import '../theme/app_theme.dart';

// void main() {
//   runApp(const MainApp());
// }

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ButtonAppBar(),
      theme: AppTheme.lightTheme,
    );
  }
}

class ButtonAppBar extends StatefulWidget {
  const ButtonAppBar({super.key});

  @override
  State<ButtonAppBar> createState() => _ButtonAppBarState();
}

class _ButtonAppBarState extends State<ButtonAppBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Home(),
    const HomeCliente(),
    const HomeVenta(),
    //const Login()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('VALISOFT'),
      // ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal.shade200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            
            for(int i = 0; i < _pages.length; i++)
            IconButton(
              icon: Icon(_getIcon(i)),
              onPressed: () {
                setState(() {
                  _selectedIndex = i;
                });
              },
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  IconData _getIcon(int index){
    switch(index){
      case 0: 
      return Icons.home;
      case 1:
      return Icons.account_box_rounded;
      case 2:
      return Icons.shopping_cart;
      // case 3:
      // return Icons.exit_to_app;
      default:
      return Icons.home;
    }
  }
}