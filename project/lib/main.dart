import 'package:flutter/material.dart';
import 'package:project/pages/client/products/list/client_products_list_page.dart';
import 'package:project/pages/delivery/oders/list/delivery_orders_list_pages.dart';
import 'package:project/pages/register/register.dart';
import 'package:project/pages/login/login.dart';
import 'package:project/pages/restaurante/orders/list/restaurant_orders_list_page.dart';
import 'package:project/pages/roles/roles_page.dart';

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
        '/roles' : (BuildContext context) => const RolesPage(),
        '/client/products/list' : (BuildContext context) => const ClientProductsListPage(),
        '/restaurante/orders/list' : (BuildContext context) => const RestaurantOrderListPage(),
        '/delivery/orders/list' : (BuildContext context) => const DeliveryOrdersListPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
