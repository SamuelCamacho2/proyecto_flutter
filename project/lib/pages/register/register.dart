import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/pages/register/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  RegisterController _con = RegisterController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 65, 
              left: 20,
              child: _iconBack(),
            ),
            Positioned(
              top: 60, 
              left: 100,
              child: _titulo(),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 150),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _imageUser(),
                    SizedBox(height: 30,),
                    _textFielEmail(),
                    _textFielNom(),
                    _textFielApell(),
                    _textFielTele(),
                    _textFielCont(),
                    _textFielCont2(),
                    _buttonCrear(),
                  ],
                ),
              ),
            )
          ],
        )
            
      ),
    );
  }

  Widget _imageUser(){
    return const CircleAvatar(
      backgroundImage: AssetImage('assets/img/user.png'),
      radius: 70,
      backgroundColor: Color.fromRGBO(174, 221, 254, 0.5),
    );
  }

  Widget _buttonCrear(){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child:  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  )
                ),
                onPressed: _con.register,
                child: const Text('Crear cuenta'),
              ),
    );
  }

  Widget _textFielEmail(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(174, 221, 254, 0.5),
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,
          decoration:const  InputDecoration(
            hintText: 'Correo Electronico',
            hintStyle: TextStyle(
              color: Colors.blue
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(Icons.email_outlined)
          ),
        ),
    );
  }

  Widget _textFielNom(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(174, 221, 254, 0.5),
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nombreController,
          decoration: const InputDecoration(
            hintText: 'Nombre',
            hintStyle: TextStyle(
              color: Colors.blue
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(Icons.person)
          ),
        ),
    );
  }

  Widget _textFielApell(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(174, 221, 254, 0.5),
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller:  _con.apellidoController,
          decoration: const InputDecoration(
            hintText: 'Apellidos',
            hintStyle: TextStyle(
              color: Colors.blue
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(Icons.person_2_outlined)
          ),
        ),
    );
  }

  Widget _textFielTele(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(174, 221, 254, 0.5),
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.telefonoController,
        keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            hintText: 'Telefono',
            hintStyle: TextStyle(
              color: Colors.blue
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(Icons.phone_android_outlined)
          ),
        ),
    );
  }

  Widget _textFielCont(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(174, 221, 254, 0.5),
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.passwordController,
        obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(
              color: Colors.blue
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(Icons.password_sharp)
          ),
        ),
    );
  }

  Widget _textFielCont2(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(174, 221, 254, 0.5),
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.password2Controller,
        obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(
              color: Colors.blue
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(Icons.password_sharp)
          ),
        ),
    );
  }


  Widget _iconBack(){
    return IconButton(
      onPressed: (){}, 
      icon: const Icon(Icons.arrow_back_ios, color: Colors.blue,)
      );
  }

  Widget _titulo(){
    return  const Text(
        'Registrate',
        style: TextStyle(
          fontSize: 50,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          color:Color.fromRGBO(29, 108, 163, 1)
        ),
      );
  }

}