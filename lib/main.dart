import 'package:flutter/material.dart';
import 'package:flutter_application_apis_proyect2/screen_views/login.dart';
import 'package:flutter_application_apis_proyect2/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Login(),
      theme: AppTheme.lightTheme,
    );
  }
}
