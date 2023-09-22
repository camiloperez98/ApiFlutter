import 'package:flutter/material.dart';

class ClienteInputForm extends StatelessWidget {
   final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? counterText;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final Icon? icon;
  final bool? enabled;
  final bool? obscureText;
  final TextEditingController? controller;
  
  const ClienteInputForm({
    super.key, 
    this.hintText, 
    this.labelText, 
    this.helperText, 
    this.counterText, 
    this.suffixIcon, 
    this.prefixIcon, 
    this.icon, 
    this.enabled, 
    this.controller, 
    this.obscureText
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      //initialValue: '',
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.phone,
      obscureText: false,
      validator: (value) {
        if(value == null) return 'Este campo es obligatorio';
          return value.length < 3 ? 'Minimo 3 caracteres': null;
      },
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
        counterText: counterText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        icon: icon
      ),
    );
  }
}