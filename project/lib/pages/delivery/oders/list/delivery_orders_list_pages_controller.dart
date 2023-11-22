import 'package:flutter/material.dart';
import 'package:project/models/user_model.dart';
import 'package:project/utils/shared_pref.dart';

class DeliveryOrdersListPageController {
  BuildContext? context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey <ScaffoldState> key = GlobalKey<ScaffoldState>();
  User? user;
  Function? refresh;

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();
  }
  void logout(){
    _sharedPref.logout(context!, user!.id!);
  }

  void operDrawer(){
    key.currentState!.openDrawer();
  }

  void goToRoles(){
    Navigator.pushNamedAndRemoveUntil(context!, '/roles', (route) => false);
  }
}