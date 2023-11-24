import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/API/environment.dart';
import 'package:project/models/orders.dart';
import 'package:project/models/response_api.dart';
import 'package:project/models/user_model.dart';
import 'package:http/http.dart' as http2;
import 'package:project/utils/shared_pref.dart';

class OrderProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/orden';
  BuildContext? context;
  User? sessionUser;

  Future? init(BuildContext context, User user) {
    this.context = context;
    this.sessionUser = user;
  }

  Future<ResponseApi> create(Order order) async {
    try {
      Uri url = Uri.http(
        _url,
        '$_api/create',
      );
      String bodyParams = json.encode(order);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        // 'Authorization': sessionUser!.sessionToken!
      };
      final res = await http2.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        SharedPref().logout(context!, sessionUser!.id!);
      }
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('error: $e');
      return ResponseApi(
          message: 'Error: $e', error: e.toString(), success: false);
    }
  }

  Future<List<Order>> lista( String status) async{
    try {
        Uri url = Uri.http(
          _url,
          '$_api/find/$status',
        );
        Map<String, String> headers = {'Content-type': 'application/json', 'Authorization': sessionUser!.sessionToken!};
        final res = await http2.get( url, headers: headers);
        if( res.statusCode == 401){
          Fluttertoast.showToast(msg: 'Sesion expirada');
          SharedPref().logout(context!, sessionUser!.id!);
        }
        final data = json.decode(res.body);
        Order orden  = Order.fromjsonList(data);
        return orden.tolist;
    } catch (e) {
      print("error $e");
      return[];
    }
  }

}
