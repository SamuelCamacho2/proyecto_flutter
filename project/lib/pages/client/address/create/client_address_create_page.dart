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
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(child: Text('Nueva Direccion', style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontFamily: 'ptsbold'))),
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
        controller: _con.refPointController,
        onTap: _con.openMap,
        autofocus: false,
        focusNode: AlwaysDisabledFocusNode(),
        decoration: InputDecoration(
          labelText: 'Punto de Referencia',
          labelStyle: TextStyle(color:Theme.of(context).colorScheme.tertiary ),
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
        controller: _con.neighborhoodController,
        decoration: InputDecoration(
          labelText: 'Ciudad',
          labelStyle: TextStyle(color:Theme.of(context).colorScheme.tertiary ),
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
        controller: _con.addressController,
        decoration: InputDecoration(
          labelText: 'Direccion',
          labelStyle: TextStyle(color:Theme.of(context).colorScheme.tertiary ),
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
        onPressed: _con.createAddress,
        child: Text('Crear Direccion', style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
