import 'package:flutter/material.dart';
import 'package:project/pages/client/products/list/client_products_list_page.dart';
import 'package:project/pages/register/register.dart';
import 'package:project/pages/login/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de envios',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login' : (BuildContext context) => const Loginpage(),
        '/register' : (BuildContext context) => const RegisterPage(),
        '/client/products/list' : (BuildContext context) => const ClientProductsListPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
