import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/pages/login/login_controller.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  LoginController? _con = LoginController();

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
              _noPassword()
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
                  style: TextStyle(color: Color.fromRGBO(29, 108, 163, 1))),
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
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
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
                    fontWeight: FontWeight.bold,
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
          style: TextStyle(color: Colors.white),
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
