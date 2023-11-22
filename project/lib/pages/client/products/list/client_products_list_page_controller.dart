import 'package:flutter/material.dart';
import 'package:project/models/category.dart';
import 'package:project/models/product_model.dart';
import 'package:project/models/user_model.dart';
import 'package:project/pages/client/detail/cliente_product_detail.dart';
import 'package:project/provider/category_provider.dart';
import 'package:project/provider/product_provider.dart';
import 'package:project/utils/shared_pref.dart';

class ClientProductsListPageController {
  BuildContext? context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  User? user;
  Function? refresh;

  CategoryProvider _categoryProvider = CategoryProvider();
  ProductProvaider _product = ProductProvaider();

  List<Categories> categories = [];

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _categoryProvider.init(context, user!);
    _product.init(context, user!);
    getCategoria();
    refresh();
  }

  Future<List<Product>> getProducts(String idCategoty) async{
    return await _product.getProductos(idCategoty);
  }


  void getCategoria()async{
    categories = await _categoryProvider.getAll();
    refresh!();
  }

  void logout() {
    _sharedPref.logout(context!, user!.id!);
  }

  void operDrawer() {
    key.currentState!.openDrawer();
  }

  void goToUpdatePage() {
    Navigator.pushNamed(context!, '/client/update');
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context!, '/roles', (route) => false);
  }
}
