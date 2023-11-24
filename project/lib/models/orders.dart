import 'dart:convert';

import 'package:project/models/product_model.dart';

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
    List<Product>? products = [];
    List<Order>? tolist = [];


    Order({
        this.id,
        this.idClient,
        this.idDelivery,
        this.idAddres,
        this.lat,
        this.lng,
        this.status,
        this.timestamp,
        this.products
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
        products: List<Product>.from(json['products'].map((model) => Product.fromJson(model))) ?? [],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "id_delivery": idDelivery,
        "id_addres": idAddres,
        "lat": lat,
        "lng": lng,
        "status": status,
        "timestamp": timestamp,
        "products": products,
    };
}