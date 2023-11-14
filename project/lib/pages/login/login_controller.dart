import 'package:flutter/material.dart';
import 'package:project/models/response_api.dart';
import 'package:project/models/user_model.dart';
import 'package:project/provider/user_provider.dart';
import 'package:project/utils/my_snackbar.dart';
import 'package:project/utils/shared_pref.dart';

class LoginController {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserProvider userProvider = UserProvider();
  SharedPref _sharedPref = SharedPref();

  Future? init(BuildContext context) async{
    this.context = context;
    await userProvider.init(context);
    User user = User.fromJson(await _sharedPref.read('user') ?? {});

    print('user: ${user.toJson()}');

    if(user.sessionToken !=null){
      Navigator.pushNamedAndRemoveUntil(context, '/client/products/list', (route) => false);
    }
  }

  void goToRegister(){
    Navigator.pushNamed(context!, '/register');
  }

  void Login() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim() ;
    ResponseApi responseApi = await userProvider.login(email, password);
    print('respuesta: ${responseApi.toJson()}');

    if (responseApi.success!) {
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());
      Navigator.pushNamedAndRemoveUntil(context!, '/client/products/list', (route) => false);
    }else{
    Mysnackbar.show(context!, responseApi.message!);
    }
    
  }
}