import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    String? id;
    String? name;
    String? description;
    String? image1;
    String? image2;
    String? image3;
    double? price;
    int? idCategoria;
    int? quantity;
    List<Product> toList = [];

    Product({
        this.id,
        this.name,
        this.description,
        this.image1,
        this.image2,
        this.image3,
        this.price,
        this.idCategoria,
        this.quantity,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] is int ? json["id"].toString() : json["id"] ?? 'null prod',
        name: json["name"] ?? 'null prod',
        description: json["description"] ?? 'null prod',
        image1: json["image1"] ?? 'null prod',
        image2: json["image2"] ?? 'null prod',
        image3: json["image3"] ?? 'null prod',
        price: json["price"] is String ? double.parse(json["price"]) : isInteger(json["price"]) ? json["price"].toDouble() : json["price"] ?? 'null prod',
        idCategoria: json["id_categoria"] is String ? int.parse(json["id_categoria"]) : json["id_categoria"] ?? 'null prod',
        quantity: json["quantity"] ?? 0,
    );

    Product.fromJsonList(List<dynamic> JsonList){
    if(JsonList == null){
      toList = [];
    }else{ JsonList.forEach((item) {
      Product product = Product.fromJson(item);
      toList.add(product);
    });}
  }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "price": price,
        "id_categoria": idCategoria,
        "quantity": quantity,
    };

    static bool isInteger(num value) => value is int || value == value.roundToDouble();
}