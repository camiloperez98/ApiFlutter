import 'package:flutter/material.dart';
import 'package:flutter_application_apis_proyect2/screen_views/buttonAppBar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  String user = 'jcperez6249@misena.edu.co';
  String pass = '1234989426';

  @override
  void dispose() {
    // Limpia los controladores cuando el widget se descarte para evitar pérdidas de memoria.
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.1,
            horizontal: MediaQuery.of(context).size.width * 0.1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://static.vecteezy.com/system/resources/thumbnails/007/407/996/small/user-icon-person-icon-client-symbol-login-head-sign-icon-design-vector.jpg',
                height: MediaQuery.of(context).size.width * 0.15,
                width: MediaQuery.of(context).size.width * 0.15,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: userController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Ingrese su usuario',
                  labelText: 'Usuario',
                  prefixIcon: Icon(Icons.assignment_ind_outlined),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: passController,
                autofocus: true,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Ingrese su contraseña',
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.password),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  final String usuario = userController.text.toLowerCase();
                  final String contrasena = passController.text.toLowerCase();
                  if (usuario.isEmpty || contrasena.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error de inicio de sesión'),
                          content: const Text(
                              'Por favor ingrese usuario y contraseña'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Aceptar'),
                            )
                          ],
                        );
                      },
                    );
                  } else {
                    if (usuario == user && contrasena == pass) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ButtonAppBar()),
                      );
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error de inicio de sesión'),
                              content: const Text(
                                  'Usuario o contraseña incorrectos'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Aceptar'),
                                )
                              ],
                            );
                          });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: const Center(
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

// import 'package:flutter/material.dart';
// import 'package:flutter_application_apis_proyect2/screen_views/buttonAppBar.dart';
// import 'package:flutter_application_apis_proyect2/screen_views/cliente_input_form.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final userController = TextEditingController();
//   final passController = TextEditingController();
//   String user = 'jcperez6249@misena.edu.co';
//   String pass = '1234989426';
//   bool ubsc = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Login',
//           style: TextStyle(fontSize: 25, color: Colors.black),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             vertical: MediaQuery.of(context).size.height * 0.1,
//             horizontal: MediaQuery.of(context).size.width * 0.1,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.network(
//                 'https://static.vecteezy.com/system/resources/thumbnails/007/407/996/small/user-icon-person-icon-client-symbol-login-head-sign-icon-design-vector.jpg',
//                 height: MediaQuery.of(context).size.width * 0.15,
//                 width: MediaQuery.of(context).size.width * 0.15,
//               ),
//               const SizedBox(height: 15),
//               ClienteInputForm(
//                 controller: userController,
//                 hintText: 'Ingrese su usuario',
//                 labelText: 'Usuario',
//                 helperText: '',
//                 counterText: '',
//                 //suffixIcon: const Icon(Icons.arrow_right),
//                 //prefixIcon: const Icon(Icons.verified_outlined),
//                 icon: const Icon(Icons.assignment_ind_outlined),
//                 obscureText: ubsc,
//               ),
//               // TextFormField(
//               //   controller: userController,
//               //   autofocus: true,
//               //   initialValue: '',
//               //   textCapitalization: TextCapitalization.words,
//               //   decoration: const InputDecoration(
//               //     hintText: 'Ingrese su usuario',
//               //     labelText: 'Usuario',
//               //     helperText: 'Solo letras',
//               //     counterText: '10 caracteres',
//               //     //prefixIcon: Icon(Icons.),
//               //     suffixIcon: Icon(Icons.verified_outlined),
//               //     icon: Icon(Icons.assignment_ind_outlined),
//               //   ),
//               //   //onChanged: (value) {},
//               // ),
//               const SizedBox(height: 15),
//                ClienteInputForm(
//                 obscureText: true,
//                 controller: passController,
//                 hintText: 'Ingrese su contraseña',
//                 labelText: 'Contraseña',
//                 helperText: '',
//                 counterText: '',
//                 //suffixIcon: const Icon(Icons.arrow_right),
//                 //prefixIcon: const Icon(Icons.verified_outlined),
//                 icon: const Icon(Icons.password),
//               ),
//               // TextFormField(
//               //   controller: passController,
//               //   autofocus: true,
//               //   initialValue: '',
//               //   textCapitalization: TextCapitalization.words,
//               //   obscureText: true,
//               //   decoration: const InputDecoration(
//               //     hintText: 'Ingrese su contraseña',
//               //     labelText: 'Contraseña',
//               //     helperText: 'Letras y números',
//               //     counterText: '20 caracteres',
//               //     //prefixIcon: Icon(Icons.verified_outlined),
//               //     suffixIcon: Icon(Icons.verified_outlined),
//               //     icon: Icon(Icons.password),
//               //   ),
//               //   //onChanged: (value) {},
//               // ),
//               const SizedBox(height: 25),
//               ElevatedButton(
//                 onPressed: () {
//                   final String usuario = userController.text.toLowerCase();
//                   final String contrasena = passController.text.toLowerCase();
//                   if (usuario.isEmpty || contrasena.isEmpty) {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: const Text('Error de inicio de sesión'),
//                           content: const Text(
//                               'Por favor ingrese usuario y contraseña'),
//                           actions: <Widget>[
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: const Text('Aceptar'),
//                             )
//                           ],
//                         );
//                       },
//                     );
//                   } else {
//                     if (usuario == user && contrasena == pass) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const ButtonAppBar()),
//                       );
//                     } else {
//                       showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: const Text('Error de inicio de sesión'),
//                               content: const Text(
//                                   'Usuario o contraseña incorrectos'),
//                               actions: <Widget>[
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: const Text('Aceptar'),
//                                 )
//                               ],
//                             );
//                           });
//                     }
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black,
//                 ),
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.4,
//                   child: const Center(
//                     child: Text('Ingresar'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
