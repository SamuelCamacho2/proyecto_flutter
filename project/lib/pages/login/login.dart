import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/firebase/auth.dart';
import 'package:project/pages/login/login_controller.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  LoginController? _con = LoginController();
  // final emailAuth = new EmailAuth();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con!.init(context);
    });
  }
  

  @override
  Widget build(BuildContext context) {
    // TextEditingController txtConUser = TextEditingController();
    // TextEditingController txtConPass = TextEditingController();

    // final btnEntrar = FloatingActionButton.extended(
    //   icon: Icon(Icons.login),
    //   label: Text('Entrar'),
      
    //   backgroundColor: Color.fromARGB(255, 12, 144, 221),
    //   onPressed: () async {
    //     bool res = await emailAuth.validateUser(emailUser: txtConUser.text, pwdUser: txtConPass.text);
    //     if(txtConUser!=null && txtConPass!=null){
    //      showDialog(context: context, 
    //       builder: (BuildContext context){
    //         return AlertDialog(
    //           title: Text('Error \n - Los campos no pueden estar vacíos \n - Correo o Contraseña Incorrectos', style: TextStyle(fontSize: 10),),
    //           icon: Icon(Icons.warning),
    //           actions: [
    //           Align(
    //               child: ElevatedButton(onPressed: (){
    //                 Navigator.of(context).pop();
    //               }, child: Text('Aceptar'),),
    //             ),
                
    //           ],
    //         );
    //       } );
    //     }if(res){
    //       Navigator.pushNamed(context, '/client/products/list');
    //     }
        
    //   },
    // );
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _titulo(),
              _imageBanner(),
              _textFielEmail(),
              _textFielCont(),
              _buttonLogin(),
              _socialLoginButtons(),
              _textNoCuenta(),
              _noPassword(),
              // TextField(
              //   enableInteractiveSelection: false,
              //   decoration: InputDecoration(
              //     hintText: 'Correo',
              //     labelText: 'Correo',
              //     suffix: Icon(
              //       Icons.verified_user
              //     ) ,
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20.0)
              //     )
              //   ),
              //   controller: txtConUser,
              // ),
              // Divider(height: 30),
              // TextField(
              //   enableInteractiveSelection: false,
              //   decoration: InputDecoration(
              //     hintText: 'Contraseña',
              //     labelText: 'Contraseña',
              //     suffix: Icon(
              //       Icons.password
              //     ),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20.0)
              //     )
              //   ),
              //   controller: txtConPass,
              //   obscureText: true,
              // ),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _noPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: _con!.goToRegister,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: const Text('Recuperar Contraseña',
                  style: TextStyle(color: Color.fromRGBO(29, 108, 163, 1),  fontFamily: 'ptsbold')),
            ))
      ],
    );
  }

  Widget _socialLoginButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _socialLoginButton(
              image: 'assets/img/gmail_logo.png', onPressed: () {}
              // onPressed: _con!.signInWithGoogle,
              ),
          _socialLoginButton(
            image: 'assets/img/facebook_logo.png',
            onPressed: () {
              // Lógica para iniciar sesión con Facebook
            },
          ),
          _socialLoginButton(
            image: 'assets/img/github_logo.png',
            onPressed: () {
              // Lógica para iniciar sesión con Github
            },
          ),
        ],
      ),
    );
  }

  Widget _socialLoginButton(
      {required String image, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(
        image,
        width: 50,
        height: 50,
      ),
    );
  }

  Widget _titulo() {
    return Container(
      padding: const EdgeInsets.only(top: 90.0),
      child: const Text(
        'Inicio de sesion',
        style: TextStyle(
            fontSize: 50,
            fontFamily: 'ptsbold',
            color: Color.fromRGBO(29, 108, 163, 1)),
      ),
    );
  }

  Widget _textNoCuenta() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: _con!.goToRegister,
            child: const Text('Crear cuenta',
                style: TextStyle(
                    fontFamily: 'ptsbold',
                    color: Color.fromRGBO(29, 108, 163, 1))))
      ],
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15, left: 30, right: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(200, 109, 191, 248),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            )),
        onPressed: _con!.Login,
        child: const Text(
          'Iniciar Sesión',
          style: TextStyle(color: Colors.white, fontFamily: 'ptsbold'),
        ),
      ),
    );
  }

  Widget _textFielEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(174, 221, 254, 0.5),
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con!.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            hintText: 'Correo Electronico',
            hintStyle: TextStyle(color: Colors.blue),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(Icons.email_outlined)),
      ),
    );
  }

  Widget _textFielCont() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(174, 221, 254, 0.5),
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con!.passwordController,
        obscureText: true,
        decoration: const InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(color: Colors.blue),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(Icons.password_sharp)),
      ),
    );
  }

  Widget _imageBanner() {
    return Container(
        margin: const EdgeInsets.only(top: 50, bottom: 30),
        child:
            Image.asset('assets/img/dirigible.png', width: 250, height: 250));
  }
}
