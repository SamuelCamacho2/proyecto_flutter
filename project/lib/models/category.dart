import 'dart:convert';

Categories categoryFromJson(String str) => Categories.fromJson(json.decode(str));

String categoryToJson(Categories data) => json.encode(data.toJson());

class Categories {
    String?  id;
    String? name;
    String? description;
    List<Categories> toList = [];

    Categories({
        this.id,
        this.name,
        this.description,
    });

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"] is int ? json["id"].toString() : json["id"] ?? 'null prod',
        name: json["name"] ?? 'null cate',
        description: json["description"] ?? 'null cate',
    );

  Categories.fromJsonList(List<dynamic> JsonList){
    if(JsonList == null) return;
    JsonList.forEach((item) {
      Categories category = Categories.fromJson(item);
      toList.add(category);
    });
  }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
    };
}
