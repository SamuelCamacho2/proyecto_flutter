import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:project/API/environment.dart';
import 'package:project/models/product_model.dart';
import 'package:project/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:project/utils/shared_pref.dart';


class ProductProvaider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/products';
  BuildContext? context;
  User? sessionUser;

  Future? init(BuildContext context, User user){
    this.context = context;
    this.sessionUser = user;
  }

  Future<Stream?> create(Product product, List<File> image) async {
    try {
      Uri url = Uri.http(
        _url,
        '$_api/create',
      );
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = sessionUser!.sessionToken!;
      for(int i = 0; i<image.length; i++){
        request.files.add(http.MultipartFile('image',
            http.ByteStream(image[i].openRead().cast()), 
            await image[i].length(),
            filename: basename(image[i].path)));
      }
      
      request.fields['product'] = json.encode(product);
      final response = await request.send(); //enviara la peticion
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<List<Product>> getProductos( String idCategoria ) async{
    try {
        Uri url = Uri.http(
          _url,
          '$_api/findcategoy/$idCategoria',
        );
        Map<String, String> headers = {'Content-type': 'application/json', 'Authorization': sessionUser!.sessionToken!};
        final res = await http.get( url, headers: headers);
        if( res.statusCode == 401){
          Fluttertoast.showToast(msg: 'Sesion expirada');
          SharedPref().logout(context!, sessionUser!.id!);
        }
        final data = json.decode(res.body);
        Product product = Product.fromJsonList(data);
        return product.toList;
    } catch (e) {
      print("error $e");
      return[];
    }
  }
}