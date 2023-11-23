import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/pages/client/address/map/client_address_map_controler.dart';

class ClientAddressMapPage extends StatefulWidget {
  const ClientAddressMapPage({super.key});

  @override
  State<ClientAddressMapPage> createState() => _ClientAddressMapPageState();
}

class _ClientAddressMapPageState extends State<ClientAddressMapPage> {
  ClientAddressMapController _con = new ClientAddressMapController();
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
        title: Text('Ubica tu direccion en el mapa'),
        backgroundColor: const Color.fromARGB(200, 109, 191, 248),
      ),
      body: Stack(
        children: [
          _googleMaps(),
          Container(
            alignment: Alignment.center,
            child: _iconMyLocation(),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.topCenter,
            child: _cardAddress(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: _buttonAccept(),
          )
        ],
      ),
    );
  }

  Widget _buttonAccept() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 40, horizontal: 70),
      child: ElevatedButton(
        onPressed: _con.selectRefPoint,
        child: Text('Seleccionar este punto'),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }

  Widget _cardAddress() {
    return Container(
      child: Card(
        color: Colors.grey[800],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            _con.addressName ?? '',
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _iconMyLocation() {
    return Image.asset(
      'assets/img/my_location.png',
      width: 65,
      height: 65,
    );
  }

  Widget _googleMaps() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initPosition,
      onMapCreated: _con.onMapCreated,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      onCameraMove: (position) {
        _con.initPosition = position;
      },
      onCameraIdle: () async {
        await _con.setLocationDraggableInfo();
      },
    );
  }

  void refresh() {
    setState(() {});
  }
}
