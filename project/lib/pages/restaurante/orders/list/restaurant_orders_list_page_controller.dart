import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project/models/orders.dart';
import 'package:project/models/user_model.dart';
import 'package:project/pages/restaurante/orders/detail/rest_orders_detail_page.dart';
import 'package:project/provider/orden_provider.dart';
import 'package:project/utils/shared_pref.dart';

class RestaurantOrdersListPageController {
  BuildContext? context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey <ScaffoldState> key = GlobalKey<ScaffoldState>();
  User? user;
  Function? refresh;
  List<String> statuss = ['PAGADO', 'CONFIRMAR', 'ENCAMINO', 'ENTREGADO'];
  OrderProvider orPro = OrderProvider();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    orPro.init(context, user!);
    refresh();
  }

  void detalleP(Order order){
      showMaterialModalBottomSheet(
        context: context!,
        builder: (context) => RestaurantDetailPage(order: order ,),
    );
  }

  Future<List<Order>> getOrder(String status) async{
    return await orPro.lista(status);
  }

  void logout(){
    _sharedPref.logout(context!, user!.id!);
  }

  void operDrawer(){
    key.currentState!.openDrawer();
  }

  void gotocategories(){ 
    Navigator.pushNamed(context!, '/restaurant/categories/create');
  }

  void gotoproducts(){
    Navigator.pushNamed(context!, '/restaurant/products/create');
  }

  void goToRoles(){
    Navigator.pushNamedAndRemoveUntil(context!, '/roles', (route) => false);
  }
}