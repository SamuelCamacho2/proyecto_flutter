import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project/models/category.dart';
import 'package:project/models/product_model.dart';
import 'package:project/models/user_model.dart';
import 'package:project/pages/client/detail/cliente_product_detail.dart';
import 'package:project/provider/category_provider.dart';
import 'package:project/provider/product_provider.dart';
import 'package:project/utils/shared_pref.dart';

class ClientOrderCreateController {
  BuildContext? context;
  Function? refresh;
  Product? product;

  SharedPref _pref = SharedPref();
  List<Product> selectedProduct = [];
  int counter = 1;
  double? productPrice;
  double total = 0;

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    var order = await _pref.read('order');
    if (order != null) {
      selectedProduct = Product.fromJsonList(order).toList;
    } else {
      selectedProduct = [];
    }
    getTotal();
    refresh();
  }

  void getTotal() {
    total = 0;
    selectedProduct.forEach((p) {
      total = total + (p.quantity! * p.price!.toDouble());
    });
    refresh!();
  }

  void addItem(Product product) {
    int index = selectedProduct.indexWhere((p) => p.id == product.id);
    selectedProduct[index].quantity = selectedProduct[index].quantity! + 1;
    _pref.save('order', selectedProduct);
    getTotal();
  }

  void removeItem(Product product) {
    if (product.quantity! > 1) {
      int index = selectedProduct.indexWhere((p) => p.id == product.id);
      selectedProduct[index].quantity = selectedProduct[index].quantity! - 1;
      _pref.save('order', selectedProduct);
      getTotal();
    }
  }

  void deleteItem(Product product) {
    selectedProduct.removeWhere((p) => p.id == product.id);
    _pref.save('order', selectedProduct);
    getTotal();
  }

  void goToAddress() {
    Navigator.pushNamed(context!, '/client/address/list');
  }
}
