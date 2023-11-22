import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/pages/restaurante/orders/list/restaurant_orders_list_page_controller.dart';

class RestaurantOrderListPage extends StatefulWidget {
  const RestaurantOrderListPage({super.key});

  @override
  State<RestaurantOrderListPage> createState() => _RestaurantOrderListPageState();
}

class _RestaurantOrderListPageState extends State<RestaurantOrderListPage> {
  RestaurantOrdersListPageController _con =RestaurantOrdersListPageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _con.key,
      appBar: AppBar(
        leading: _menuDrawe(),
      ),
      drawer: _drawe(),
      body: Center(
        child: Text('RestaurantOrderListPage'),
      ),
    );
  }

  Widget _menuDrawe(){
    return GestureDetector(
      onTap: _con!.operDrawer,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        child: Image.asset('assets/img/more.png', width: 20, height: 20,),
      ),
    );
  }

  Widget _drawe(){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration:const  BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( 
                  '${_con?.user?.name ?? ''} ${_con?.user?.lastname ?? ''}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  maxLines: 1,
                ),
                Text( 
                  _con?.user?.email ?? '',
                  style:const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                ),
                Text( 
                  _con?.user?.phone ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                ),
                Container(
                  height: 60,
                  margin: const EdgeInsets.only(top: 10),
                  child: const FadeInImage(
                    image: AssetImage('assets/img/nota.png'),
                    fit: BoxFit.contain,
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/img/nota.png'),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: _con.gotocategories,
            title: const Text('Crear categoria'),
            trailing: const Icon(Icons.list_alt),
          ),
          ListTile(
            onTap: _con.gotoproducts,
            title: const Text('Crear Producto'),
            trailing: const Icon(Icons.production_quantity_limits),
          ),
          _con.user != null ?
          _con.user!.roles!.length > 1 ?
          ListTile(
            onTap: _con.goToRoles,
            title: const Text('Seleccionar rol'),
            trailing: const Icon(Icons.person_outline_outlined),
          ) : Container() : Container(),
          
          ListTile(
            onTap: _con.logout,
            title: const Text('Cerrar sesion'),
            trailing: const Icon(Icons.logout_outlined),
          ),
        ],
      )
    );
  }

  void refresh(){
    setState(() {});
  }
}