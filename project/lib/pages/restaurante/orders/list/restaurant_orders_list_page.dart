import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/models/orders.dart';
import 'package:project/pages/restaurante/orders/list/restaurant_orders_list_page_controller.dart';
import 'package:project/widget/no_data_widget.dart';

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
    return DefaultTabController(
      length: _con!.statuss.length,
      child: Scaffold(
        key: _con!.key,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(200, 109, 191, 248),
            flexibleSpace: Column(
              children: [
                const SizedBox(height: 55,),
                _menuDrawe(),
              ],
            ),
            bottom: TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              tabs: List<Widget>.generate(_con!.statuss.length, (index){
                return Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    _con!.statuss[index] ?? '', 
                    style: const TextStyle( fontSize: 17),
                  ),
                );
              }),
            ),
          ),
        ),
        drawer: _drawe(),
        body: TabBarView(
          children: _con!.statuss.map((String status){
            return FutureBuilder(
              future: _con.getOrder(status),
              builder: (context, AsyncSnapshot<List<Order>> snapshot){
                if (snapshot.hasData) {
                  if(snapshot.data!.length > 0){
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (_,index){
                        return _Card(snapshot.data![index]);
                      }
                    );
                  }else{
                    return NoDataWidget(text: 'No hay ordenes');
                  }
                }else{
                  return NoDataWidget(text: 'No hay ordenes');
                }
              }
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _Card(Order order){
    return GestureDetector(
      onTap:(){
        _con.detalleP(order);
      },
      child: Container(
        height: 160,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(200, 109, 191, 248),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)
                    )
                  ),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Orden # ${order.id}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'NimbusSans'
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                child:  Column(
                  children:  [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: const Text(
                        'Pedido: ',
                        style: TextStyle(
                          fontSize: 13
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'Cliente: ${order.cliente?.name ?? ''} ${order.cliente?.lastname ?? ''}',
                        style:const TextStyle(
                          fontSize: 13
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child:  Text(
                        'Entregar en: ${order.addres?.address ?? ''}',
                        style: const TextStyle(
                          fontSize: 13
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
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