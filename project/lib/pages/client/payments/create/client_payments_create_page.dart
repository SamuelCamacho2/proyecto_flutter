import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/pages/client/payments/create/client_payments_create_controller.dart';
import 'package:project/pages/client/payments/status/client_payments_status_page.dart';

class ClientPaymentsCreatePage extends StatefulWidget {
  const ClientPaymentsCreatePage({super.key});

  @override
  State<ClientPaymentsCreatePage> createState() =>
      _ClientPaymentsCreatePageState();
}

class _ClientPaymentsCreatePageState extends State<ClientPaymentsCreatePage> {
  ClientPaymentsCreateController _con = new ClientPaymentsCreateController();

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
      appBar: AppBar(title: Text('Pagos')),
      body: ListView(
        children: [
          CreditCardWidget(
            cardNumber: _con.cardNumber,
            expiryDate: _con.expireDate,
            cardHolderName: _con.cardHolderName,
            cvvCode: _con.cvvCode,
            showBackView: _con.isCvvFocused,
            onCreditCardWidgetChange: (CreditCardBrand brand) {},
            labelCardHolder: 'Nombre y Apellido',
          ),
          CreditCardForm(
            formKey: _con.keyForm, // Required
            cardNumber: _con.cardNumber, // Required
            expiryDate: _con.expireDate, // Required
            cardHolderName: _con.cardHolderName, // Required
            cvvCode: _con.cvvCode, // Required
            // cardNumberKey: cardNumberKey,
            // cvvCodeKey: cvvCodeKey,
            // expiryDateKey: expiryDateKey,
            // cardHolderKey: cardHolderKey,
            onCreditCardModelChange: _con.onCreditCardModelChanged, // Required
            obscureCvv: true,
            obscureNumber: true,
            isHolderNameVisible: true,
            isCardNumberVisible: true,
            isExpiryDateVisible: true,
            enableCvv: true,
            cvvValidationMessage: 'Please input a valid CVV',
            dateValidationMessage: 'Please input a valid date',
            numberValidationMessage: 'Please input a valid number',
            cardNumberValidator: (String? cardNumber) {},
            expiryDateValidator: (String? expiryDate) {},
            cvvValidator: (String? cvv) {},
            cardHolderValidator: (String? cardHolderName) {},
            onFormComplete: () {
              // callback to execute at the end of filling card data
            },
            autovalidateMode: AutovalidateMode.always,
            disableCardNumberAutoFillHints: false,
            inputConfiguration: const InputConfiguration(
              cardNumberDecoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Numero de la tarjeta',
                hintText: 'XXXX XXXX XXXX XXXX',
              ),
              expiryDateDecoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Fecha de Expiracion',
                hintText: 'XX/XX',
              ),
              cvvCodeDecoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CVV',
                hintText: 'XXX',
              ),
              cardHolderDecoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre del titular',
              ),
              cardNumberTextStyle: TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
              cardHolderTextStyle: TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
              expiryDateTextStyle: TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
              cvvCodeTextStyle: TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
            ),
          ),
          _buttonNext()
        ],
      ),
    );
  }

  bool _validateFields() {
    // Validar la longitud de cada campo y generar mensajes de error
    String errorMessage;
    print('Variable mide: ${_con.cvvCode.length}');
    if (_con.cardNumber.length != 19) {
      errorMessage = "El número de tarjeta debe contener 16 dígitos.";
    } else if (_con.expireDate.length != 5) {
      errorMessage = "La fecha de vencimiento debe contener 4 dígitos.";
    } else if (_con.cvvCode.length < 3) {
      errorMessage = "El código CVV debe contener 3 dígitos.";
    } else if (_con.cardHolderName.length < 5) {
      errorMessage = "Escribe un nombre real";
    } else {
      // Todos los campos son válidos
      return true;
    }

    // Mostrar notificación de error
    _showValidationNotification(errorMessage);
    return false;
  }

  void _showValidationNotification(String errorMessage) {
    Fluttertoast.showToast(msg: errorMessage);
    // Fluttertoast.showToast(
    //   msg: errorMessage,
    //   toastLength: Toast.LENGTH_LONG,
    //   gravity: ToastGravity.BOTTOM,
    //   backgroundColor: Colors.red,
    //   textColor: Colors.white,
    // );
  }

  Widget _buttonNext() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
      child: ElevatedButton(
        onPressed: () {
          if (_validateFields()) {
            String ultimosCuatroDigitos =
                _con.cardNumber.substring(_con.cardNumber.length - 4);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ClientPaymentsStatusPage(
                        cardNumber: ultimosCuatroDigitos,
                        cardHolderName: _con.cardHolderName)));
          }
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
                  "CONTINUAR",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  color: Colors.white),
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

  void refresh() {
    setState(() {});
  }
}
