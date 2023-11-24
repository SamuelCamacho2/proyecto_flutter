import 'package:flutter/material.dart';
import 'package:project/models/address.dart';
import 'package:project/models/orders.dart';
import 'package:project/models/product_model.dart';
import 'package:project/models/response_api.dart';
import 'package:project/models/user_model.dart';
import 'package:project/provider/address_provider.dart';
import 'package:project/provider/orden_provider.dart';
import 'package:project/utils/shared_pref.dart';

class ClientAddressListController {
  BuildContext? context;
  Function? refresh;
  List<Address> address = [];
  AddressProvider _addressProvider = new AddressProvider();
  User? user;
  SharedPref _sharedPref = new SharedPref();
  int radioValue = 0;
  bool? isCreated;
  OrderProvider _orderProvider = OrderProvider();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    
    _addressProvider.init(context, user!);
    _orderProvider.init(context, user!);
    refresh();
  }

  void createOrden() async{
    Address a = Address.fromJson(await _sharedPref.read('address') ?? {});
    List<Product> selectedProduct = Product.fromJsonList(await _sharedPref.read('order')).toList;
    Order order = Order(
      idClient: user!.id,
      idAddres: a.id,
      products: selectedProduct
    );
    ResponseApi responseApi = await _orderProvider.create(order);
    print('orden creada: ${responseApi.message}');
  }

  void handleRadioValueChange(int value) async {
    radioValue = value;
    _sharedPref.save('address', address[value]);
    Address a = Address.fromJson(await _sharedPref.read('address') ?? {});
    print('Se guardo la direccion: ${a.toJson()}');
    refresh!();
    print('Valor seleccionado: $radioValue');
  }

  Future<List<Address>> getAddress() async {
    if (user != null && user!.id != null) {
      address = await _addressProvider.getByUser(user!.id!);
      return address;
    } else {
      return [];
    }
    // address = await _addressProvider.getByUser(user!.id!);
    // return address;
  }

  void goToNewAddress() async {
    var result = await Navigator.pushNamed(context!, '/client/address/create');
    if (result != null) {
      if (result == true) {
        refresh!();
      }
    }
  }
}
