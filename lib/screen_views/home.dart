import 'package:flutter/material.dart';

import 'login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login', style: TextStyle(fontSize: 25),),
      // ),
      body:   SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('VALISOFT',style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
            const SizedBox(height: 20),
            Image.network('https://thefoodtech.com/wp-content/uploads/2020/05/productos-diaego.jpg'),
            const SizedBox(height: 10),
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
          ],
        ),
        ),
      ),
    );
  }
}