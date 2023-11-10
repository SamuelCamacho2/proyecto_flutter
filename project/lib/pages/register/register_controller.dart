import 'package:flutter/material.dart';
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

  Future? init(BuildContext context){
    this.context = context;
    userProvider.init(context);
  }

  void register() async{
    String email = emailController.text.trim();
    String nombre = nombreController.text;
    String apellidos = apellidoController.text;
    String telefono = telefonoController.text.trim();
    String password = passwordController.text.trim();
    String password2 = password2Controller.text.trim();

    if(email.isEmpty || nombre.isEmpty || apellidos.isEmpty || telefono.isEmpty || password.isEmpty || password2.isEmpty){
      Mysnackbar.show(context! ,'Campos imcompletos');
      return;
    }

    if (password2 != password) {
      Mysnackbar.show(context!, 'Las contrasenas no coinciden');
      return;
    }

    if(password.length < 6){
      Mysnackbar.show(context!, 'Las contrasenas debe tener al menos 6 caracteres');
      return;
    }

    User user =  User(
      email: email,
      name: nombre,
      lastname: apellidos,
      phone: telefono,
      password: password,
    );

    ResponseApi responseApi = await userProvider.create(user);
    Mysnackbar.show(context!, responseApi.message.toString());
    print('responseApi: ${responseApi.toJson()}');
  }

}