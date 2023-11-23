import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/API/environment.dart';
import 'package:project/models/address.dart';
import 'package:project/models/response_api.dart';
import 'package:project/models/user_model.dart';
import 'package:http/http.dart' as http2;
import 'package:project/utils/shared_pref.dart';

class AddressProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/address';
  BuildContext? context;
  User? sessionUser;

  get http => null;

  Future? init(BuildContext context, User user) {
    this.context = context;
    this.sessionUser = user;
  }

  Future<List<Address>> getByUser(String idUser) async {
    try {
      Uri url = Uri.http(
        _url,
        '$_api/findByUser/${idUser}',
      );
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };
      final res = await http2.get(url, headers: headers);
      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        SharedPref().logout(context!, sessionUser!.id!);
      }
      final data = json.decode(res.body);
      Address address = Address.fromJsonList(data);
      return address.toList;
    } catch (e) {
      print("error $e");
      return [];
    }
  }

  Future<ResponseApi> create(Address address) async {
    try {
      Uri url = Uri.http(
        _url,
        '$_api/create',
      );
      String bodyParams = json.encode(address);
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
}
