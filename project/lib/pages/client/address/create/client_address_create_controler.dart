import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project/models/address.dart';
import 'package:project/models/response_api.dart';
import 'package:project/models/user_model.dart';
import 'package:project/pages/client/address/map/client_address_map_page.dart';
import 'package:project/provider/address_provider.dart';
import 'package:project/utils/my_snackbar.dart';
import 'package:project/utils/shared_pref.dart';

class ClientAddressCreateController {
  BuildContext? context;
  Function? refresh;
  TextEditingController? refPointController = new TextEditingController();
  TextEditingController? addressController = new TextEditingController();
  TextEditingController? neighborhoodController = new TextEditingController();
  Map<String, dynamic>? refPoint;

  AddressProvider _addressProvider = new AddressProvider();
  User? user;
  SharedPref _sharedPref = new SharedPref();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _addressProvider.init(context, user!);
  }

  void createAddress() async {
    String addressName = addressController!.text;
    String neighborhood = neighborhoodController!.text;
    double lat = refPoint!['lat'] ?? 0;
    double lng = refPoint!['lng'] ?? 0;

    if (addressName.isEmpty || neighborhood.isEmpty || lat == 0 || lng == 0) {
      Mysnackbar.show(context!, 'Completa todos los campos');
      return;
    }

    Address address = new Address(
        address: addressName,
        neighborhood: neighborhood,
        lat: lat,
        lng: lng,
        idUser: user!.id);

    ResponseApi responseApi = await _addressProvider.create(address);

    if (responseApi.success!) {
      Fluttertoast.showToast(msg: responseApi.message!);
      Navigator.pop(context!);
    }
  }

  void openMap() async {
    refPoint = await showMaterialModalBottomSheet(
        context: context!,
        isDismissible: false,
        enableDrag: false,
        builder: (context) => ClientAddressMapPage());
    if (refPoint != null) {
      refPointController!.text = refPoint!['address'];
      refresh!();
    }
  }
}
