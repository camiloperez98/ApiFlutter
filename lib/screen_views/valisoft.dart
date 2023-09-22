import 'package:flutter/material.dart';

import '../loginNuevo.dart';

class Valisoft extends StatefulWidget {
  const Valisoft({super.key});

  @override
  State<Valisoft> createState() => _ValisoftState();
}

class _ValisoftState extends State<Valisoft> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginViewComponent()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Espaciado interior
            child: Icon(
              Icons.android_sharp,
              size: MediaQuery.of(context).size.width * 0.4, // Tamaño relativo a la pantalla
              color: Colors.teal.shade400,
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_application_apis_proyect2/screen_views/login.dart';

// class Valisoft extends StatefulWidget {
//   const Valisoft({super.key});

//   @override
//   State<Valisoft> createState() => _ValisoftState();
// }

// class _ValisoftState extends State<Valisoft> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 180, horizontal: 400),
//           child: Center(
//             child: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const Login()),
//                   );
//                 },
//                 child: Icon(Icons.android_sharp,
//                 size: 300,
//                 color: Colors.teal.shade400),
//               ),
//           ),
//         ),
//       ),
//     );
//   }
// }
