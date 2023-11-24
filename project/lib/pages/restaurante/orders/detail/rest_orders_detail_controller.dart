import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:project/models/orders.dart';
import 'package:project/models/product_model.dart';
import 'package:project/utils/shared_pref.dart';

class RestaurantDetailController {
  BuildContext? context;
  Function? refresh;
  Product? product;

  SharedPref _pref = SharedPref();
  int counter = 1;
  double? productPrice;
  double total = 0;
  Order? orden;

  Future? init(BuildContext context, Function refresh, Order orden) async {
    this.context = context;
    this.refresh = refresh;
    this.orden = orden;
    getTotal();
    refresh();
  }

  void getTotal() {
    total = 0;
    refresh!();
  }

}
