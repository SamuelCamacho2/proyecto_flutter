import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/API/environment.dart';
import 'package:project/models/response_api.dart';
import 'package:flutter/material.dart';
import 'package:project/models/user_model.dart';
import 'package:http/http.dart' as http;


class UserProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/users';

  BuildContext? context;

  Future? init(BuildContext context) {
    this.context = context;
  }

  Future<ResponseApi> create(User user)async{

    try {
      Uri url = Uri.http( _url, '$_api/register',);
      String bodyParams = json.encode(user);
      Map<String, String> headers = {
        'Content-type' : 'application/json'
      }; 
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('error: $e');
      return ResponseApi(
        message: 'Error: $e',
        error: e.toString(),
        succes: false
      );
    }
    
  }
}