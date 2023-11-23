
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/models/product_model.dart';
import 'package:project/utils/shared_pref.dart';

class CienteProducDetailController {
  BuildContext? context;
  Function? refresh;
  Product? product;

  SharedPref _pref = SharedPref();
  List<Product> selectedProduct = [];

  int counter = 1;
  double? productPrice;
  Future? init(BuildContext context, Function refresh, Product product) async{
    this.context=context;
    this.refresh=refresh;
    this.product=product;
    productPrice = product.price;
    var order = await _pref.read('order');
    if (order != null) {
      selectedProduct = Product.fromJsonList(order).toList;
    } else {
      selectedProduct = [];
    }
    refresh();
  }

  void addToBag(){
    int index = selectedProduct.indexWhere((p) => p.id == product!.id);
    if(index == -1){
      if(product!.quantity == null){
        product!.quantity = 1;
      }
      selectedProduct.add(product!);
    }else{
      selectedProduct[index].quantity = counter;
    }
    _pref.save('order', selectedProduct);
    Fluttertoast.showToast(msg: 'Producto agregado');
  }

  void addItem(){
    counter = counter + 1;
    productPrice = product!.price! * counter;
    product?.quantity = counter;
    refresh!();
  }

  void removeItem(){
    if (counter > 1) {
      counter = counter - 1;
      productPrice = product!.price! * counter;
      product?.quantity = counter;
      refresh!();
    }
  }

  void close(){
    Navigator.pop(context!);
  }
}