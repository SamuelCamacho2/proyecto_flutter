import 'package:flutter/material.dart';
import 'package:project/utils/shared_pref.dart';

class ClientProductsListPageController {
  BuildContext? context;
  SharedPref _sharedPref = SharedPref();

  Future? init(BuildContext context) {
    this.context = context;
  }

  logout(){
    _sharedPref.logout(context!);
  }
}