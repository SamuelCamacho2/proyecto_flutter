import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/pages/delivery/oders/list/delivery_orders_list_pages_controller.dart';

class DeliveryOrdersListPage extends StatefulWidget {
  const DeliveryOrdersListPage({super.key});

  @override
  State<DeliveryOrdersListPage> createState() => _DeliveryOrdersListPageState();
}

class _DeliveryOrdersListPageState extends State<DeliveryOrdersListPage> {
  DeliveryOrdersListPageController _con =DeliveryOrdersListPageController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar: AppBar(
        leading: _menuDrawe(),
      ),
      drawer: _drawe(),
      body: Center(
        child: Text('DeliveryOrdersListPage'),
      ),
    );
  }

  Widget _menuDrawe(){
    return GestureDetector(
      onTap: _con.operDrawer,
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