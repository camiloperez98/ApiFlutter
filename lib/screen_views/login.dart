import 'package:flutter/material.dart';
import 'package:flutter_application_apis_proyect2/apis/client_post.dart';
import 'package:flutter_application_apis_proyect2/screen_views/buttonAppBar.dart';
import 'package:flutter_application_apis_proyect2/screen_views/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userController = TextEditingController();
  final passController = TextEditingController(); 
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(fontSize: 25, color: Colors.black),),
      ),
      body:   SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 400),
        child: Column(
          children: [
            Image.network('https://static.vecteezy.com/system/resources/thumbnails/007/407/996/small/user-icon-person-icon-client-symbol-login-head-sign-icon-design-vector.jpg', height: 110, width: 110,),
            const SizedBox(height: 15),
            TextFormField(
      autofocus: true,
      initialValue: '',
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        hintText: 'Ingrese su usuario',
        labelText: 'Usuario',
        helperText: 'Solo letras',
        counterText: '10 caracteres',
        //prefixIcon: Icon(Icons.),
        suffixIcon: Icon(Icons.verified_outlined),
        icon: Icon(Icons.assignment_ind_outlined)
      ),
      onChanged: (value) {
        print('value: $value');
      },
    ),
    const SizedBox(height: 15),
    TextFormField(
      autofocus: true,
      initialValue: '',
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        hintText: 'Ingrese su contraseña',
        labelText: 'Contraseña',
        helperText: 'Letras y numeros',
        counterText: '20 caracteres',
        //prefixIcon: Icon(Icons.verified_outlined),
        suffixIcon: Icon(Icons.verified_outlined),
        icon: Icon(Icons.password)
      ),
      onChanged: (value) {
        print('value: $value');
      },
    ),
    const SizedBox(height: 25),
    ElevatedButton(
      onPressed: () {
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>const ButtonAppBar()),
          );
      },
         style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
  ),
      child:  const SizedBox(
        width: 100,
        child: Center(
          child: Text('Ingresar'),
        ),
        ),
    ),
          ],
        ),
        ),
      ),
    );
  }
}