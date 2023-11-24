import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:project/pages/client/payments/status/client_payments_status_controller.dart';
import 'package:project/pages/client/products/list/client_products_list_page.dart';

class ClientPaymentsStatusPage extends StatefulWidget {
  final String cardNumber;
  final String cardHolderName;
  ClientPaymentsStatusPage(
      {super.key, required this.cardNumber, required this.cardHolderName});

  @override
  State<ClientPaymentsStatusPage> createState() =>
      _ClientPaymentsStatusPageState();
}

class _ClientPaymentsStatusPageState extends State<ClientPaymentsStatusPage> {
  ClientPaymentsStatusController _con = new ClientPaymentsStatusController();

  @override
  Widget build(BuildContext context) {
    // Utiliza widget.cardNumber y widget.cardHolderName para acceder a los datos
    print("Card Number: ${widget.cardNumber}");
    print("Card Holder Name: ${widget.cardHolderName}");

    // Resto del código
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _clipPathOval(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Text(
              'Tu orden fue procesada exitosamente usando (VISA **** ${widget.cardNumber})',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Text(
              'Gracias, ${widget.cardHolderName} por su compra!!',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 150,
        child: _buttonNext(),
      ),
    );
  }

  Widget _buttonNext() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ClientProductsListPage()));
        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  "FINALIZAR COMPRA",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 50, top: 4),
                height: 30,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _clipPathOval() {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        height: 250,
        width: double.infinity,
        color: Colors.blue,
        child: SafeArea(
          child: Column(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 150,
              ),
              Text(
                'Gracias por su compra',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
