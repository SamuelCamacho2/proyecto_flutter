import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/API/environment.dart';
import 'package:project/models/response_api.dart';
import 'package:flutter/material.dart';
import 'package:project/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:project/utils/shared_pref.dart';

class UserProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/users';
  User? sessionUser;

  BuildContext? context;

  Future? init(BuildContext context, {User? sessionUser} ) {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<User?> getId(String id) async {
    try {
      Uri url = Uri.http(
        _url,
        '$_api/findId/$id',
      );
      Map<String, String> headers = {'Content-type': 'application/json', 'Authorization': sessionUser!.sessionToken! }; 
      final res = await http.get(url, headers: headers);

      if (res.statusCode ==401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        SharedPref().logout(context!, sessionUser!.id!);
      }

      final data = json.decode(res.body);
      User user = User.fromJson(data);
      return user;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Stream?> createWithImage(User user, File image) async {
    try {
      Uri url = Uri.http(
        _url,
        '$_api/register',
      );
      final request = http.MultipartRequest('POST', url);

      if (image != null) {
        request.files.add(http.MultipartFile('image',
            http.ByteStream(image.openRead().cast()), await image.length(),
            filename: basename(image.path)));
      }
      request.fields['user'] = json.encode(user);
      final response = await request.send(); //enviara la peticion
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Stream?> update(User user, File image) async {
    try {
      Uri url = Uri.http(
        _url,
        '$_api/update',
      );
      final request = http.MultipartRequest('PUT', url);
      request.headers['Authorization'] = sessionUser!.sessionToken!;

      if (image != null) {
        request.files.add(http.MultipartFile('image',
            http.ByteStream(image.openRead().cast()), await image.length(),
            filename: basename(image.path)));
      }
      request.fields['user'] = json.encode(user);
      final response = await request.send(); //enviara la peticion
      if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        SharedPref().logout(context!, sessionUser!.id!);
      }else{
        return response.stream.transform(utf8.decoder);
      }
      
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> create(User user) async {
    try {
      Uri url = Uri.http(
        _url,
        '$_api/register',
      );
      String bodyParams = json.encode(user);
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('error: $e');
      return ResponseApi(
          message: 'Error: $e', error: e.toString(), success: false);
    }
  }

  Future<ResponseApi> logout(String iduser) async {
    try {
      Uri url = Uri.http(
        _url,
        '$_api/logout',
      );
      String bodyParams = json.encode({
        'id': iduser
      });
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('error: $e');
      return ResponseApi(
          message: 'Error: $e', error: e.toString(), success: false);
    }
  }

  Future<ResponseApi> login(String email, String password) async {
    try {
      Uri url = Uri.http(
        _url,
        '$_api/login',
      );
      String bodyParams = json.encode({'email': email, 'password': password});
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('error: $e');
      return ResponseApi(
          message: 'Error: $e', error: e.toString(), success: false);
    }
  }
}
