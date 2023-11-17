import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/models/response_api.dart';
import 'package:project/models/user_model.dart';
import 'package:project/provider/user_provider.dart';
import 'package:project/utils/my_snackbar.dart';

class RegisterController {
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  UserProvider userProvider = UserProvider();

  PickedFile? pickedFile;
  File? imageFile;
  Function? refresh;

  Future? init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
    userProvider.init(context);
  }

  void register() async {
    String email = emailController.text.trim();
    String nombre = nombreController.text;
    String apellidos = apellidoController.text;
    String telefono = telefonoController.text.trim();
    String password = passwordController.text.trim();
    String password2 = password2Controller.text.trim();

    if (email.isEmpty ||
        nombre.isEmpty ||
        apellidos.isEmpty ||
        telefono.isEmpty ||
        password.isEmpty ||
        password2.isEmpty) {
      Mysnackbar.show(context!, 'Campos imcompletos');
      return;
    }

    if (password2 != password) {
      Mysnackbar.show(context!, 'Las contrasenas no coinciden');
      return;
    }

    if (password.length < 6) {
      Mysnackbar.show(
          context!, 'Las contrasenas debe tener al menos 6 caracteres');
      return;
    }

    if (imageFile == null) {
      Mysnackbar.show(context!, 'Selecciona una imagen');
      return;
    }

    User user = User(
      email: email,
      name: nombre,
      lastname: apellidos,
      phone: telefono,
      password: password,
    );

    // Stream? stream = await userProvider.createWithImage(user, imageFile!);
    // stream!.listen((res) {
    //   // ResponseApi responseApi = await userProvider.create(user);
    //   ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
    //   print('responseApi: ${responseApi.toJson()}');
    //   Mysnackbar.show(context!, responseApi.message.toString());

    //   if (responseApi.success!) {
    //     Future.delayed(Duration(seconds: 3), () {
    //       Navigator.pushReplacementNamed(context!, '/login');
    //     });
    //   }
    // });

    ResponseApi responseApi = await userProvider.create(user);
    print('responseApi: ${responseApi.toJson()}');
    Mysnackbar.show(context!, responseApi.message.toString());

    if (responseApi.success!) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context!, '/login');
      });
    }
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
