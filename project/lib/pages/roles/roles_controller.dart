import 'package:flutter/material.dart';
import 'package:project/models/user_model.dart';
import 'package:project/utils/shared_pref.dart';

class RolesController {
  
  Function? refresh;
  BuildContext? context;
  User? user;
  SharedPref sharedPref = SharedPref();

  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user') ?? {});
    refresh();
  }

  void goToPage(String routeName){
    Navigator.pushNamedAndRemoveUntil(context!, routeName, (route) => false);
  }

}