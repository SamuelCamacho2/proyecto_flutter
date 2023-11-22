import 'package:flutter/material.dart';
import 'package:project/models/category.dart';
import 'package:project/models/response_api.dart';
import 'package:project/models/user_model.dart';
import 'package:project/provider/category_provider.dart';
import 'package:project/utils/my_snackbar.dart';
import 'package:project/utils/shared_pref.dart';

class RestaurantCategoriesController {

  BuildContext? context;
  Function? refresh;

  TextEditingController maneController = TextEditingController();
  TextEditingController descController = TextEditingController();

  CategoryProvider _categoryProvider = CategoryProvider();
  User? user;
  SharedPref sharedPref = SharedPref();

  Future? init(BuildContext context,Function refresh )async{
    this.context=context;
    this.refresh=refresh;
    user = User.fromJson(await sharedPref.read('user'));
    _categoryProvider.init(context, user!);
  }

  void createCategory() async{
    String name = maneController.text;
    String desc = descController.text;

    if(name.isEmpty || desc.isEmpty){
      Mysnackbar.show(context!, 'Llena todos los campos');
      return;
    }

    Categories category = Categories(
      name: name,
      description : desc
    );

    ResponseApi responseApi = await _categoryProvider.create(category);
    Mysnackbar.show(context!, responseApi.message!);

    if(responseApi.success!){
      maneController.text = '';
      descController.text = '';
    }
  }
}