import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/pages/client/update/client_update_controller.dart';

class ClientUpdatePage extends StatefulWidget {
  const ClientUpdatePage({super.key});

  @override
  State<ClientUpdatePage> createState() => _ClientUpdatePageState();
}

class _ClientUpdatePageState extends State<ClientUpdatePage> {
  ClientUpdateController _con = ClientUpdateController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Center(child: Text('Editar Perfil', style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontFamily: 'ptsbold'),)),
      backgroundColor: Theme.of(context).colorScheme.primary,
      
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              _imageUser(),
              SizedBox(
                height: 30,
              ),
              _textFielNom(),
              _textFielApell(),
              _textFielTele(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buttonCrear(),
    );
  }

  Widget _imageUser() {
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: CircleAvatar(
        // backgroundImage: AssetImage('assets/img/user.png'),
        backgroundImage: _con.imageFile != null
            ? FileImage(_con.imageFile!) as ImageProvider<Object>?
            : _con.user?.image != null
                ? NetworkImage(_con.user!.image!)
                : AssetImage('assets/img/user.png') as ImageProvider<Object>?,

        radius: 70,
        backgroundColor: Color.fromRGBO(174, 221, 254, 0.5),
      ),
    );
  }

  Widget _buttonCrear() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).colorScheme.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            )),
        onPressed: _con.isEnable ? _con.update : null,
        child: const Text('Actualizar Perfil', style:  TextStyle(color: Colors.white),),
      ),
    );
  }

  Widget _textFielNom() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.nombreController,
        decoration: const InputDecoration(
            hintText: 'Nombre',
            hintStyle: TextStyle(color: Colors.blue),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(Icons.person)),
      ),
    );
  }

  Widget _textFielApell() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.apellidoController,
        decoration: const InputDecoration(
            hintText: 'Apellidos',
            hintStyle: TextStyle(color: Colors.blue),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(Icons.person_2_outlined)),
      ),
    );
  }

  Widget _textFielTele() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.telefonoController,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
            hintText: 'Telefono',
            hintStyle: TextStyle(color: Colors.blue),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(Icons.phone_android_outlined,),),
      ),
    );
  }

  Widget _titulo() {
    return const Text(
      'Registrate',
      style: TextStyle(
          fontSize: 50,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(29, 108, 163, 1)),
    );
  }

  void refresh() {
    setState(() {});
  }
}
