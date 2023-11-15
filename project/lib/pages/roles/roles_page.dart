import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/models/rol_model.dart';
import 'package:project/pages/roles/roles_controller.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({super.key});

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  RolesController _con = RolesController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona un rol')
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10),
        child: ListView(
          children: _con.user != null ? _con.user!.roles!.map((Rol rol) {
            return _cardRol(rol);
          }).toList() : []
        ),
      )
    );
  }

  Widget _cardRol(Rol rol){
    return GestureDetector(
      onTap: (){
        _con.goToPage(rol.route);
      
      },
      child: Column(
        children: [
          Container(
            height: 100,
            child: FadeInImage(
              placeholder: const AssetImage('assets/img/nota.png'),
              image: rol.image != '' 
                ? const AssetImage('assets/img/nota.png') //NetworkImage(rol.image)
                : const AssetImage('assets/img/nota.png') as ImageProvider,
              fit: BoxFit.contain,
              fadeInDuration: const Duration(milliseconds: 50),
            ),
          ),
          Text(rol.name ?? '',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
    
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}