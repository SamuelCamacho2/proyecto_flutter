import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/models/response_api.dart';
import 'package:project/models/user_model.dart';
import 'package:project/provider/user_provider.dart';
import 'package:project/utils/my_snackbar.dart';
import 'package:project/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ClientUpdateController {
  BuildContext? context;
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();

  UserProvider userProvider = UserProvider();

  PickedFile? pickedFile;
  File? imageFile;
  Function? refresh;

  ProgressDialog? _progressDialog;

  bool isEnable = true;

  User? user;
  SharedPref _sharedPref = new SharedPref();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    userProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));

    nombreController.text = user!.name;
    apellidoController.text = user!.lastname;
    telefonoController.text = user!.phone;
    refresh();
  }

  void register() async {
    String nombre = nombreController.text;
    String apellidos = apellidoController.text;
    String telefono = telefonoController.text.trim();

    if (nombre.isEmpty || apellidos.isEmpty || telefono.isEmpty) {
      Mysnackbar.show(context!, 'Campos imcompletos');
      return;
    }

    if (imageFile == null) {
      Mysnackbar.show(context!, 'Selecciona una imagen');
      return;
    }

    _progressDialog!.show(max: 100, msg: 'Espere un momento');
    isEnable = false;

    User user = new User(
      name: nombre,
      lastname: apellidos,
      phone: telefono,
    );

    Stream? stream = await userProvider.createWithImage(user, imageFile!);
    stream!.listen((res) {
      _progressDialog!.close();
      // ResponseApi responseApi = await userProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print('responseApi: ${responseApi.toJson()}');
      Mysnackbar.show(context!, responseApi.message.toString());

      if (responseApi.success!) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context!, '/login');
        });
      } else {
        isEnable = true;
      }
    });
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context!);
    refresh!();
  }

  void showAlertDialog() {
    Widget galleryButtom = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: Text('GALERIA'));

    Widget cameraButtom = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
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

  void back() {
    Navigator.pop(context!);
  }
}
