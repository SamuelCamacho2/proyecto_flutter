import 'dart:ffi';

import 'package:flutter/material.dart';

class Mysnackbar {
  
  static void show(BuildContext context, String text) {
    if (context == null) return;

    FocusScope.of(context).requestFocus(new FocusNode());
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 14)),
      backgroundColor: Colors.black,
      duration: Duration(seconds: 3),
    ));
  }
}
