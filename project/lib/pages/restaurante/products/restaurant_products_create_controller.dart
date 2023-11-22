import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/models/category.dart';
import 'package:project/models/product_model.dart';
import 'package:project/models/response_api.dart';
import 'package:project/models/user_model.dart';
import 'package:project/provider/category_provider.dart';
import 'package:project/provider/product_provider.dart';
import 'package:project/utils/my_snackbar.dart';
import 'package:project/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RestaurantProductPageController {

  BuildContext? context;
  Function? refresh;

  TextEditingController maneController = TextEditingController();
  TextEditingController descController = TextEditingController();
  MoneyMaskedTextController priceController = MoneyMaskedTextController();
  ProductProvaider productProvaider = ProductProvaider();

  CategoryProvider _categoryProvider = CategoryProvider();
  User? user;
  SharedPref sharedPref = SharedPref();
  List<Categories> categories = [];
  String? idCategory;

  PickedFile? pickedFile;
  File? image1;
  File? image2;
  File? image3;
  ProgressDialog? progressDialog;


  Future? init(BuildContext context,Function refresh )async{
    this.context=context;
    this.refresh=refresh;
    progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await sharedPref.read('user'));
    _categoryProvider.init(context, user!);
    productProvaider.init(context, user!);
    getCategories();
  }

  void getCategories() async {
    categories = await _categoryProvider.getAll();
    refresh!();
  }

  void createProducto() async{
    String name = maneController.text;
    String desc = descController.text;
    double price = priceController.numberValue;

    if(name.isEmpty || desc.isEmpty || price == 0){
      Mysnackbar.show(context!, 'Llena todos los campos');
      return;
    }
    if(image1 == null || image2 == null || image3 == null){
      Mysnackbar.show(context!, 'Selecciona tus imagenes');
      return;
    }
    if(idCategory == null){
      Mysnackbar.show(context!, 'Selecciona la categoria');
      return;
    }
    Product product = Product(
      name: name, 
      description: desc, 
      price: price,
      idCategoria: int.parse(idCategory!),
      );

      List<File> image = [];
      image.add(image1!);
      image.add(image2!);
      image.add(image3!);

      progressDialog!.show(max: 100, msg: 'Espere un momento');
      Stream? stream = await productProvaider.create(product, image);
      stream?.listen((res){
        progressDialog!.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        Mysnackbar.show(context!, responseApi.message!);
        print('respuesta: ${responseApi.toJson()}');
        if(responseApi.success!){
          resetValue();
        }
      });

    print('Formulario producto: ${product.toJson()}');
  }
  void resetValue(){
    maneController.text= '';
    descController.text ='';
    priceController.text = '0.0';
    image1 = null;
    image2 = null;
    image3 = null;
    idCategory = null;
    refresh!();
  }

  Future selectImage(ImageSource imageSource, int numberFiler) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {

      if(numberFiler ==1){
        image1 = File(pickedFile.path);
      }else if(numberFiler ==2){
        image2 = File(pickedFile.path);
      }else if(numberFiler ==3){
        image3 = File(pickedFile.path);
      }

    }
    Navigator.pop(context!);
    refresh!();
  }

  void showAlertDialog( int numberfile) {
    Widget galleryButtom = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery, numberfile);
        },
        child: Text('GALERIA'));

    Widget cameraButtom = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera, numberfile);
        },
        child: Text('CAMARA'));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [galleryButtom, cameraButtom],
    );

    showDialog(
        context: context!,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}