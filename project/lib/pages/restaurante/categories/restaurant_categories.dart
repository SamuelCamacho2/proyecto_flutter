import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/pages/restaurante/categories/restaurant_categories_controller.dart';

class RestaurantCategoriesPage extends StatefulWidget {
  const RestaurantCategoriesPage({super.key});

  @override
  State<RestaurantCategoriesPage> createState() => _RestaurantCategoriesPageState();
}

class _RestaurantCategoriesPageState extends State<RestaurantCategoriesPage> {
  RestaurantCategoriesController _con = RestaurantCategoriesController();

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
        title: Text('nueva categoria'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          _textFielCate(),
          const SizedBox(height: 30),
          _textFielDesc()
        ],
      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  Widget _textFielCate(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(174, 221, 254, 0.5),
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
          controller: _con.maneController,
          decoration: const InputDecoration(
            hintText: 'Nombre de la categoria',
            hintStyle: TextStyle(
              color: Colors.blue
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(Icons.category_outlined)
          ),
        ),
    );
  }

  Widget _textFielDesc(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(174, 221, 254, 0.5),
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
          controller: _con.descController,
          maxLines: 3,
          maxLength: 255,
          decoration: const InputDecoration(
            hintText: 'Descripcion...',
            hintStyle: TextStyle(
              color: Colors.blue
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(Icons.description)
          ),
        ),
    );
  }

  Widget _buttonCreate(){
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child:  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(200, 109, 191, 248),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  )
                ),
                onPressed: _con.createCategory,
                child: const Text('Crear categoria', style: TextStyle(color: Colors.white),),
              ),
    );
  }

  void refresh(){
    setState(() {
      
    });
  }

}