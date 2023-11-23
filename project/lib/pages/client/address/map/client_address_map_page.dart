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
        children: [_googleMaps()],
      ),
    );
  }

  Widget _googleMaps() {
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _con.initPosition,
        onMapCreated: _con.onMapCreated);
  }

  void refresh() {
    setState(() {});
  }
}
