import 'dart:convert';

import 'package:project/models/address.dart';
import 'package:project/models/product_model.dart';
import 'package:project/models/user_model.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
    String? id;
    String? idClient;
    String? idDelivery;
    String? idAddres;
    double? lat;
    double? lng;
    String? status;
    int? timestamp;
    List<Product>? productos = [];
    List<Order> tolist = [];
    User? cliente;
    Address? addres;


    Order({
        this.id,
        this.idClient,
        this.idDelivery,
        this.idAddres,
        this.lat,
        this.lng,
        this.status,
        this.timestamp,
        this.productos,
        this.cliente,
        this.addres
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] is int ? json["id"].toString() : json["id"],
        idClient: json["id_client"],
        idDelivery: json["id_delivery"],
        idAddres: json["id_addres"],
        lat: json["lat"] is String ? double.parse(json["lat"]) : json["lat"],
        lng: json["lng"] is String ? double.parse(json["lng"]) : json["lng"],
        status: json["status"],
        timestamp: json["timestamp"] is String ? int.parse(json["timestamp"]) : json["timestamp"],
        productos: json["productos"] != null ? List<Product>.from(json['productos'].map((model) => Product.fromJson(model))) : [],
        cliente: json["cliente"] is String ? userFromJson(json["cliente"]) : User.fromJson(json["cliente"] ?? {}),
        addres: json["address"] is String ? addressFromJson(json["address"]) : Address.fromJson(json["address"] ?? {})
    );

    Order.fromjsonList(List<dynamic> jsonlist){
      if (jsonlist == null) return;
      jsonlist.forEach((item) { 
        Order order = Order.fromJson(item);
        tolist!.add(order);
      });
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "id_delivery": idDelivery,
        "id_addres": idAddres,
        "lat": lat,
        "lng": lng,
        "status": status,
        "timestamp": timestamp,
        "productos": productos,
        "cliente": cliente,
        "address": addres,
    };
}