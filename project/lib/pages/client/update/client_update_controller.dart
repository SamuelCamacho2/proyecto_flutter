import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));
    print('TOKEN : ${user!.sessionToken}');
    print('imagen : ${user!.image}');
    userProvider.init(context, sessionUser: user); //


    nombreController.text = user!.name;
    apellidoController.text = user!.lastname;
    telefonoController.text = user!.phone;
    refresh();
  }

  void update() async {
    String nombre = nombreController.text;
    String apellidos = apellidoController.text;
    String telefono = telefonoController.text.trim();

    if (nombre.isEmpty || apellidos.isEmpty || telefono.isEmpty) {
      Mysnackbar.show(context!, 'Campos imcompletos');
      return;
    }

    _progressDialog!.show(max: 100, msg: 'Espere un momento');
    isEnable = false;

    User myUser = User(
      id: user!.id,
      name: nombre,
      lastname: apellidos,
      phone: telefono,
      image: user!.image
    );

    
    Stream? stream = await userProvider.update(myUser, imageFile!);
    stream?.listen((res) async {
      _progressDialog!.close();

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      Fluttertoast.showToast(msg: responseApi.message.toString());
      if (responseApi.success!) {
        user = await userProvider
            .getId(myUser.id!); // obteniendo el usuario de la base de datos
        _sharedPref.save('user', user!.toJson());
        Navigator.pushNamedAndRemoveUntil(
            context!, '/client/products/list', (route) => false);
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
