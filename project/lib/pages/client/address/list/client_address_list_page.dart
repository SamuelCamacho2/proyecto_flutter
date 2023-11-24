import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/models/address.dart';
import 'package:project/pages/client/address/list/client_address_list_controler.dart';
import 'package:project/widget/no_data_widget.dart';

class ClienAddressListPage extends StatefulWidget {
  const ClienAddressListPage({super.key});

  @override
  State<ClienAddressListPage> createState() => _ClienAddressListPageState();
}

class _ClienAddressListPageState extends State<ClienAddressListPage> {
  ClientAddressListController _con = new ClientAddressListController();
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
        title: Text('Direcciones'),
        backgroundColor: const Color.fromARGB(200, 109, 191, 248),
        actions: [_iconAdd()],
      ),
      body: Stack(
        children: [
          Positioned(top: 0, child: _textSelectAddress()),
          Container(margin: EdgeInsets.only(top: 75), child: _listAddress())
        ],
      ),
      bottomNavigationBar: _buttonAccept(),
    );
  }

  Widget _noAddress() {
    return Center(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: NoDataWidget(text: 'Agrega una nueva direccion'),
          ),
          _buttonNewAddress(),
        ],
      ),
    );
  }

  Widget _listAddress() {
    return FutureBuilder(
        future: _con.getAddress(),
        builder: (context, AsyncSnapshot<List<Address>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (_, index) {
                    return _radioSelectorAddress(snapshot.data![index], index);
                  });
            } else {
              return _noAddress();
            }
          } else {
            return _noAddress();
          }
        });
  }

  Widget _radioSelectorAddress(Address address, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(children: [
            Radio(
              value: index,
              groupValue: _con.radioValue,
              onChanged: (value) => _con.handleRadioValueChange(value!),
              // onChanged: _con.handleRadioValueChange,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.address ?? '',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                Text(
                  address.neighborhood ?? '',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ]),
          Divider(
            color: Colors.grey[400],
          )
        ],
      ),
    );
  }

  Widget _buttonNewAddress() {
    return Container(
      height: 40,
      child: ElevatedButton(
          onPressed: _con.goToNewAddress,
          child: Text('Nueva Direccion'),
          style: ElevatedButton.styleFrom(primary: Colors.blue)),
    );
  }

  Widget _buttonAccept() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 40, horizontal: 50),
      child: ElevatedButton(
        onPressed: _con.createOrden,
        child: Text('Aceptar'),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }

  Widget _textSelectAddress() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text(
        'Elige donde recibir tus compras',
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _iconAdd() {
    return IconButton(
        onPressed: _con.goToNewAddress,
        icon: Icon(Icons.add, color: Colors.white));
  }

  void refresh() {
    setState(() {});
  }
}
