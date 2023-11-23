import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientAddressMapController {
  BuildContext? context;
  Function? refresh;

  CameraPosition initPosition = CameraPosition(
      target: LatLng(20.528918054788072, -100.83324552175375), zoom: 14);

  Completer<GoogleMapController> _mapController = Completer();

  Future? init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }
}
