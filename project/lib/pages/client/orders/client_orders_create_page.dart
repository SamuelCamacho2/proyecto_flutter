import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/models/product_model.dart';
import 'package:project/pages/client/orders/client_orders_create_page_controller.dart';
import 'package:project/widget/no_data_widget.dart';

class ClientOrderCreatePage extends StatefulWidget {
  const ClientOrderCreatePage({super.key});

  @override
  State<ClientOrderCreatePage> createState() => _ClientOrderCreatePageState();
}

class _ClientOrderCreatePageState extends State<ClientOrderCreatePage> {
  ClientOrderCreateController _con = ClientOrderCreateController();

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
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(200, 109, 191, 248),
            title: const Center(
                child: Text(
              'Mi orden',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ))),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.24,
          child: Column(
            children: [
              const Divider(
                color: Color.fromARGB(255, 218, 217, 217),
                endIndent: 30,
                indent: 30,
              ),
              _textTotal(),
              _boton(),
            ],
          ),
        ),
        body: _con.selectedProduct.length > 0
            ? ListView(
                children: _con.selectedProduct.map((Product product) {
                  return _cardProduct(product);
                }).toList(),
              )
            : Center(child: NoDataWidget(text: "No hay productos en orden")));
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _imagen(product),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name!.length > 10 ? '${product.name?.substring(0,8)}...' : product.name ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _contador(product)
            ],
          ),
          const Spacer(),
          Column(
            children: [_txtPrice(product), _delete(product)],
          )
        ],
      ),
    );
  }

  Widget _boton() {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
      child: ElevatedButton(
          onPressed: _con.goToAddress,
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(200, 109, 191, 248),
              padding: const EdgeInsets.symmetric(vertical: 5)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    'Continuar a pagar',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 50, top: 9),
                  height: 30,
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _textTotal() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Text(
            '\$${_con.total}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }

  Widget _delete(Product product) {
    return IconButton(
        onPressed: () {
          _con.deleteItem(product);
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ));
  }

  Widget _txtPrice(Product product) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        '${product.price! * product.quantity!}',
        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _imagen(Product product) {
    return Container(
      width: 90,
      height: 90,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: const Color.fromARGB(255, 222, 241, 255)),
      child: FadeInImage(
        placeholder: const AssetImage('assets/img/nota.png'),
        image: product.image1 != null
            ? NetworkImage(product.image1!) as ImageProvider<Object>
            : const AssetImage('assets/img/nota.png'),
        fit: BoxFit.contain,
        fadeInDuration: const Duration(milliseconds: 50),
      ),
    );
  }

  Widget _contador(Product product) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            _con.removeItem(product);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              color: Color.fromARGB(255, 222, 241, 255),
            ),
            child: const Text('-'),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          color: const Color.fromARGB(255, 222, 241, 255),
          child: Text('${product.quantity ?? 0}'),
        ),
        GestureDetector(
          onTap: () {
            _con.addItem(product);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              color: Color.fromARGB(255, 222, 241, 255),
            ),
            child: const Text('+'),
          ),
        ),
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
