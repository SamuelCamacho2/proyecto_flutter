import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/pages/client/products/list/client_products_list_page_controller.dart';

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({super.key});

  @override
  State<ClientProductsListPage> createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  
  ClientProductsListPageController? _con = ClientProductsListPageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con!.init(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child: ElevatedButton(
          onPressed: _con!.logout,
          child: Text('Cerrar sesión'),
        ),
      ),
    );
  }
}