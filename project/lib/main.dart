import 'package:flutter/material.dart';
import 'package:project/pages/client/products/list/client_products_list_page.dart';
import 'package:project/pages/client/update/client_update.dart';
import 'package:project/pages/delivery/oders/list/delivery_orders_list_pages.dart';
import 'package:project/pages/register/register.dart';
import 'package:project/pages/login/login.dart';
import 'package:project/pages/restaurante/categories/restaurant_categories.dart';
import 'package:project/pages/restaurante/orders/list/restaurant_orders_list_page.dart';
import 'package:project/pages/restaurante/products/restaurant_products_create.dart';
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
        '/login': (BuildContext context) => const Loginpage(),
        '/register': (BuildContext context) => const RegisterPage(),
        '/roles': (BuildContext context) => const RolesPage(),

        '/client/products/list': (BuildContext context) =>const ClientProductsListPage(),
        '/client/update': (BuildContext context) => const ClientUpdatePage(),

        '/restaurante/orders/list': (BuildContext context) =>const RestaurantOrderListPage(),
        '/restaurant/categories/create': (BuildContext context) => const RestaurantCategoriesPage(),
        '/restaurant/products/create' : (BuildContext context) => const RestaurantProductPage(),
        
        '/delivery/orders/list': (BuildContext context) =>const DeliveryOrdersListPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(elevation: 0)
      ),
    );
  }
}
