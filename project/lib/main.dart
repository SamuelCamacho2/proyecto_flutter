
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/firebase/notificaciones.dart';
import 'package:project/pages/client/address/create/client_address_create_page.dart';
import 'package:project/pages/client/address/list/client_address_list_page.dart';
import 'package:project/pages/client/address/map/client_address_map_page.dart';
import 'package:project/pages/client/orders/client_orders_create_page.dart';
import 'package:project/pages/client/payments/create/client_payments_create_page.dart';
import 'package:project/pages/client/products/list/client_products_list_page.dart';
import 'package:project/pages/client/update/client_update.dart';
import 'package:project/pages/delivery/oders/list/delivery_orders_list_pages.dart';
import 'package:project/pages/login/presentacion.dart';
import 'package:project/pages/register/register.dart';
import 'package:project/pages/login/login.dart';
import 'package:project/pages/restaurante/categories/restaurant_categories.dart';
import 'package:project/pages/restaurante/orders/list/restaurant_orders_list_page.dart';
import 'package:project/pages/restaurante/products/restaurant_products_create.dart';
import 'package:project/pages/roles/roles_page.dart';
import 'package:project/utils/globalvalues.dart';
import 'package:project/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';


int? incio;
// void main() {
//   runApp(MainApp());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   Platform.isAndroid
        ? await Firebase.initializeApp(
            options: const FirebaseOptions(
                apiKey: "AIzaSyB1zlpvOosyBl84omOs2iNa4oBsu3rsL4M",
                appId: "1:1081676872654:android:aa66ed842a91b3ce42099f",
                messagingSenderId: "1081676872654",
                projectId: "moviles-64123"))
        : await Firebase.initializeApp();
  NotificationService notificaciones = NotificationService();
  await notificaciones.initNotifications();
  SharedPreferences guardar = await SharedPreferences.getInstance();
  incio = await guardar.getInt('incio');
  await guardar.setInt('incio', 1);
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    GlobalValues().readValue();
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:  GlobalValues.flagTheme,
      builder: (context, value, _) {
        return  MaterialApp(
          title: 'App de envios',
          debugShowCheckedModeBanner: false,
          theme: value ? MyTheme.darktheme(context) : MyTheme.lightTheme(context),
          initialRoute: incio == 0 || incio== null ? '/presentacion' : '/login',
          routes: {
            '/presentacion': (BuildContext context) => const Presentacion(),
            '/login': (BuildContext context) => const Loginpage(),
            '/register': (BuildContext context) => const RegisterPage(),
            '/roles': (BuildContext context) => const RolesPage(),
            '/client/products/list': (BuildContext context) =>
                const ClientProductsListPage(),
            '/client/update': (BuildContext context) => const ClientUpdatePage(),
            '/client/orders/create': (BuildContext context) =>
                const ClientOrderCreatePage(),
            '/client/address/list': (BuildContext context) =>
                const ClienAddressListPage(),
            '/client/address/create': (BuildContext context) =>
                const ClienAddressCreatePage(),
            '/client/payments/create': (BuildContext context) =>
                const ClientPaymentsCreatePage(),
            '/client/address/map': (BuildContext context) =>
                const ClientAddressMapPage(),
            '/restaurante/orders/list': (BuildContext context) =>
                const RestaurantOrderListPage(),
            '/restaurant/categories/create': (BuildContext context) =>
                const RestaurantCategoriesPage(),
            '/restaurant/products/create': (BuildContext context) =>
                const RestaurantProductPage(),
            '/delivery/orders/list': (BuildContext context) =>
                const DeliveryOrdersListPage(),
          },
        );
      },
    );
  }
}
