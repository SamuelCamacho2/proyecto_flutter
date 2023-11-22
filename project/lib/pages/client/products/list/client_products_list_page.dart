import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/models/category.dart';
import 'package:project/models/product_model.dart';
import 'package:project/pages/client/products/list/client_products_list_page_controller.dart';
import 'package:project/widget/no_data_widget.dart';

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
      _con!.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _con!.categories.length,
      child: Scaffold(
        key: _con!.key,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(157),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(200, 109, 191, 248),
            actions: [
              shopingback()
            ],
            flexibleSpace: Column(
              children: [
                const SizedBox(height: 55,),
                _menuDrawe(),
                const SizedBox(height: 20,),
                _textBuscar()
              ],
            ),
            bottom: TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              tabs: List<Widget>.generate(_con!.categories.length, (index){
                return Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    _con!.categories[index].name ?? '', 
                    style: const TextStyle( fontSize: 17),
                  ),
                );
              }),
            ),
          ),
        ),
        drawer: _drawe(),
        body: TabBarView(
          children: _con!.categories.map((Categories categoria){
            return FutureBuilder(
              future: _con!.getProducts(categoria.id!), 
              builder: (context, AsyncSnapshot<List<Product>> snapshot){
                if (snapshot.hasData) {
                  if(snapshot.data!.length > 0){
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7
                      ), 
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (_,index){
                        return _cardProduct(snapshot.data![index]);
                      }
                    );
                  }else{
                    return NoDataWidget(text: 'No hay productos');
                  }
                }else{
                  return NoDataWidget(text: 'No hay productos');
                }
              }
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _menuDrawe() {
    return GestureDetector(
      onTap: _con!.operDrawer,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        child: Image.asset(
          'assets/img/more.png',
          width: 20,
          height: 20,
        ),
      ),
    );
  }

  Widget _cardProduct( Product producto){
    return Container(
      height: 250,
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        child: Stack(
          children: [
            Positioned(
              top: -1,
              right: -1.0,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(200, 109, 191, 248),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(20)
                  )
                ),
                child: const Icon(Icons.add, color: Colors.white,),
              )
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * 0.45,
                  padding: const EdgeInsets.all(20),
                  child:  FadeInImage(
                    placeholder: const  AssetImage('assets/img/nota.png'), 
                    image: producto.image1 != null
                      ? NetworkImage(producto.image1!) as ImageProvider<Object>
                      : const AssetImage('assets/img/nota.png'),
                    fit: BoxFit.contain,
                    fadeInDuration: const Duration(milliseconds: 50),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 43,
                  child: Text(
                    producto.name ?? 'sin nombre',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'NimbusSans'
                    ),
                  ),
                ),
              const Spacer(),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text(
                    '${producto.price ?? '--.--'}' ,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NimbusSans'
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _drawe() {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Color.fromARGB(200, 109, 191, 248),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_con?.user?.name ?? ''} ${_con?.user?.lastname ?? ''}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
              Text(
                _con?.user?.email ?? '',
                style: const TextStyle(
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
          onTap: _con!.goToUpdatePage,
          title: const Text('Editar perfil'),
          trailing: const Icon(Icons.edit_outlined),
        ),
        const ListTile(
          title: Text('Mispedidos'),
          trailing: Icon(Icons.shopping_cart_outlined),
        ),
        _con!.user != null
            ? _con!.user!.roles!.length > 1
                ? ListTile(
                    onTap: _con!.goToRoles,
                    title: const Text('Seleccionar rol'),
                    trailing: const Icon(Icons.person_outline_outlined),
                  )
                : Container()
            : Container(),
        ListTile(
          onTap: _con!.logout,
          title: const Text('Cerrar sesion'),
          trailing: const Icon(Icons.logout_outlined),
        ),
      ],
    ));
  }

  Widget _textBuscar(){
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar...',
          suffixIcon: const Icon(
            Icons.search,
            color: Colors.black
          ),
          hintStyle: const TextStyle(
            fontSize: 17,
            color: Colors.black
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Colors.black
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Colors.black
            )
          ),
          contentPadding: const EdgeInsets.all(14)
        ),
      ),
    );
  }

  Widget shopingback(){
    return Stack(
      children:[
          Container( 
          margin: const EdgeInsets.only(right: 15),
          child: const Icon(
            Icons.shopping_bag,
            color: Colors.black,
          ),
        ),
        Positioned(
          right: 15,
          child: Container(
            width: 9,
            height: 9,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),
          )
        )
      ]
    );
  }

  void refresh() {
    setState(() {});
  }
}
