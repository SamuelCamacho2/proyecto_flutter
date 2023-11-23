import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/pages/client/address/create/client_address_create_controler.dart';

class ClienAddressCreatePage extends StatefulWidget {
  const ClienAddressCreatePage({super.key});

  @override
  State<ClienAddressCreatePage> createState() => _ClienAddressCreatePageState();
}

class _ClienAddressCreatePageState extends State<ClienAddressCreatePage> {
  ClientAddressCreateController _con = new ClientAddressCreateController();
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
        title: Text('Nueva Direccion'),
        backgroundColor: const Color.fromARGB(200, 109, 191, 248),
      ),
      body: Column(
        children: [
          _textCompleteData(),
          _textFieldAddress(),
          _textFieldNeighborhood(),
          _textFieldRefPoint()
        ],
      ),
      bottomNavigationBar: _buttonAccept(),
    );
  }

  Widget _textFieldRefPoint() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        onTap: _con.openMap,
        autofocus: false,
        focusNode: AlwaysDisabledFocusNode(),
        decoration: InputDecoration(
          labelText: 'Punto de Referencia',
          suffixIcon: Icon(
            Icons.map,
          ),
        ),
      ),
    );
  }

  Widget _textFieldNeighborhood() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Ciudad',
          suffixIcon: Icon(
            Icons.location_city,
          ),
        ),
      ),
    );
  }

  Widget _textFieldAddress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Direccion',
          suffixIcon: Icon(
            Icons.location_on,
          ),
        ),
      ),
    );
  }

  Widget _textCompleteData() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text(
        'Completa estos datos',
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buttonAccept() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 40, horizontal: 50),
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Crear Direccion'),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          // primary: MyColors.primaryColors
          // colorcar
          // el siguiente codigo
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
