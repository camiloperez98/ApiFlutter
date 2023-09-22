import 'package:flutter/material.dart';
import 'package:flutter_application_apis_proyect2/screen_views/buttonAppBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

DataModelUsuario dataModelFromJson(String str) => DataModelUsuario.fromJson(json.decode(str));

String dataModelToJson(DataModelUsuario data) => json.encode(data.toJson());



class DataModelUsuario {
  DataModelUsuario({
    required this.usuarios
  });
  
  List<Usuario> usuarios;

  factory DataModelUsuario.fromJson(Map<String, dynamic> json)=> DataModelUsuario(
    usuarios: List<Usuario>.from(json["users"].map((x)=> Usuario.fromJson(x)))
  );

  Map<String, dynamic> toJson() => {
    "users": List<dynamic>.from(usuarios.map((x)=> x.toJson()))
  };
}

class Usuario {
  final String id;
  String name;
  String tel;
  String email;
  String password;
  String rol;

  Usuario({
    required this.id,
    required this.name,
    required this.tel,
    required this.email,
    required this.password,
    required this.rol,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["_id"],
        name: json["name"],
        tel: json["tel"],
        email: json["email"],
        password: json["password"],
        rol: json["rol"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "tel": tel,
        "email": email,
        "password": password,
        "rol": rol,
      };
}

class LoginViewComponent extends StatefulWidget {
  const LoginViewComponent({Key? key}) : super(key: key);

  @override
  State<LoginViewComponent> createState() => _LoginViewComponentState();
}

class _LoginViewComponentState extends State<LoginViewComponent> {
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey =
      GlobalKey<FormState>(); // Agregar una clave global para el formulario

  // Correo y contraseña para ingresar
  final String validEmail = 'correo@ejemplo.com';
  final String validPassword = '123';

  @override
  void initState() {
    super.initState();
    _getUsuarios();
  }

  DataModelUsuario? _dataModelUsuario;

  _getUsuarios() async {
    isLoading = true;
    try {
      String url = 'https://coff-v-art-api.onrender.com/api/user';
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        _dataModelUsuario = DataModelUsuario.fromJson(json.decode(res.body));
        isLoading = false;
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
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.teal.shade200,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Asociar el formulario con la clave global
          child: Column(
            children: [
              Image.network(
                'https://static.vecteezy.com/system/resources/thumbnails/007/407/996/small/user-icon-person-icon-client-symbol-login-head-sign-icon-design-vector.jpg',
                height: MediaQuery.of(context).size.width * 0.15,
                width: MediaQuery.of(context).size.width * 0.15,
              ),
              const SizedBox(height: 16.0),
             TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Usuario',
            icon: Icon(Icons.person), // Icono para el campo de usuario
          ),
        ),
        const SizedBox(height: 15,),
        TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(
            labelText: 'Contraseña',
            icon: Icon(Icons.lock), // Icono para el campo de contraseña
          ),
          obscureText: true,
        ),
        const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // validamos credenciales
                    final enteredEmail = _emailController.text.trim();
                    final enteredPassword = _passwordController.text.trim();
                    int positionUsuario = -1;

                    // Search the email and password in the list
                    for (int i = 0;
                        i < _dataModelUsuario!.usuarios.length;
                        i++) {
                      if (_dataModelUsuario!.usuarios[i].email ==
                              enteredEmail &&
                          _dataModelUsuario!.usuarios[i].password ==
                              enteredPassword) {
                        positionUsuario = i;
                        break;
                      }
                    }

                    // If the email and password is correct
                    if (positionUsuario != -1) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const ButtonAppBar(),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Correo o contraseña errados')),
                      );
                    }

                    // if (enteredEmail == validEmail &&
                    //     enteredPassword == validPassword) {
                    //   Text('Hola');
                    //   // Navigator.of(context).pushReplacement(MaterialPageRoute
                    //   // (builder: (context) => const WelcomeView(),
                    //   // ),
                    //   // );
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //         content: Text('Correo o contraseña errados')),
                    //   );
                    // }
                  }
                },
                child: const Text('Ingresar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}