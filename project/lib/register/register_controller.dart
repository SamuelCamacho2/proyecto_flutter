import 'package:flutter/material.dart';

class RegisterController {
  
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  Future? init(BuildContext context){
    this.context = context;
  }

  void register(){
    String email = emailController.text.trim();
    String nombre = nombreController.text;
    String apellidos = apellidoController.text;
    String telefono = telefonoController.text.trim();
    String password = passwordController.text.trim();
    String password2 = password2Controller.text.trim();

    print(email);
    print(nombre);
    print(apellidos);
    print(telefono);
    print(password);
    print(password2);

    
  }

}