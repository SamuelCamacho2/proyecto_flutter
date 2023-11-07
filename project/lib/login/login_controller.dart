import 'package:flutter/material.dart';

class LoginController {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future? init(BuildContext context){
    this.context = context;
  }

  void goToRegister(){
    Navigator.pushNamed(context!, '/register');
  }

  void Login(){
    String email = emailController.text.trim();
    String password = passwordController.text.trim() ;

    print(email);
    print(password);
  }
}