import 'package:flutter/material.dart';

class RestaurantOrderListPage extends StatefulWidget {
  const RestaurantOrderListPage({super.key});

  @override
  State<RestaurantOrderListPage> createState() => _RestaurantOrderListPageState();
}

class _RestaurantOrderListPageState extends State<RestaurantOrderListPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('RestaurantOrderListPage'),
      ),
    );
  }
}