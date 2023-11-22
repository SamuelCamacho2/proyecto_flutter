import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/models/category.dart';
import 'package:project/pages/restaurante/products/restaurant_products_create_controller.dart';

class RestaurantProductPage extends StatefulWidget {
  const RestaurantProductPage({super.key});

  @override
  State<RestaurantProductPage> createState() => _RestaurantProductPageState();
}

class _RestaurantProductPageState extends State<RestaurantProductPage> {
  RestaurantProductPageController _con = RestaurantProductPageController();

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
        title: const Text('Nuevo producto'),
      ),
      body: ListView(
            children: [
              const SizedBox(height: 50),
              _textFielCate(),
              _textFielDesc(),
              _textFielPrice(),
              Container(
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _cardImage(_con.image1, 1),
                    _cardImage(_con.image2, 2),
                    _cardImage(_con.image3, 3),
                  ],
                ),
              ),
              _dropDownCategories(_con.categories)
            ],
        ),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  Widget _dropDownCategories(List<Categories> category){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Material(
        elevation: 2.0,
        color: const Color.fromARGB(200, 163, 217, 255),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
                const Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.blue
                    ),
                    SizedBox(width: 10,),
                    Text(
                      'Categoria',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButton(
                    underline: Container(
                      alignment: Alignment.centerRight,
                      child:const  Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.blue,
                      ),
                    ),
                    elevation: 3,
                    isExpanded: true,
                    hint: const Text(
                      'Selecciona una categoria',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16
                      ),
                    ),
                    items: _dropDownItem(category),
                    value: _con.idCategory,
                    onChanged: (option){
                      setState(() {
                        print('id seleccionado $option');
                        _con.idCategory = option;
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItem(List<Categories> categoria){
    List<DropdownMenuItem<String>> list = [];
    categoria.forEach((category) {
      list.add(DropdownMenuItem(
        child: Text(category.name!),
        value: category.id,
      ));
    });
    return list;
  }

  Widget _textFielCate(){
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(174, 221, 254, 0.5),
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
          controller: _con.maneController,
          maxLines: 1,
          maxLength: 180,
          decoration: const InputDecoration(
            hintText: 'Nombre del producto',
            hintStyle: TextStyle(
              color: Colors.blue
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(Icons.auto_awesome_mosaic)
          ),
        ),
    );
  }

  Widget _textFielDesc(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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

  Widget _textFielPrice(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(174, 221, 254, 0.5),
        borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
          controller: _con.priceController,
          keyboardType: TextInputType.phone,
          maxLines: 1,
          decoration: const InputDecoration(
            hintText: 'Precio del producto',
            hintStyle: TextStyle(
              color: Colors.blue
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(Icons.monetization_on)
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
                onPressed: _con.createProducto,
                child: const Text('Crear Producto', style: TextStyle(color: Colors.white),),
              ),
    );
  }

  Widget _cardImage(File? imageFile, int numberFile){
    return GestureDetector(
      onTap: (){
        _con.showAlertDialog(numberFile);
      },
      child: imageFile != null ?
      Card(
        elevation: 3.0,
        child: Container(
          height: 140,
          width: MediaQuery.of(context).size.width * 0.26,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
          ),
        ),
      )
      : Card(
          elevation: 3.0,
          child: Container(
            height: 140,
            width: MediaQuery.of(context).size.width * 0.26,
            child: const Image(
              image: AssetImage('assets/img/imagen.png'),
            ),
          ),
      ),
    );
  }

  void refresh(){
    setState(() {
      
    });
  }

}