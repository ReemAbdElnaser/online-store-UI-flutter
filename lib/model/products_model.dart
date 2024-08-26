// To parse this JSON data, do
//
//     final productsmodel = productsmodelFromJson(jsonString);

import 'dart:convert';

Productsmodel productsmodelFromJson(String str) => Productsmodel.fromJson(json.decode(str));

String productsmodelToJson(Productsmodel data) => json.encode(data.toJson());

class Productsmodel {
    final List<Product>? products;
    final int? total;
    final int? skip;
    final int? limit;

    Productsmodel({
        this.products,
        this.total,
        this.skip,
        this.limit,
    });

    factory Productsmodel.fromJson(Map<String, dynamic> json) => Productsmodel(
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
    };
}

class Product {
    final int? id;
    final String? title;
    final String? description;
    final double? price;
    final Category? category;
    final String? thumbnail;

    Product({
        this.id,
        this.title,
        this.description,
        this.price,
        this.category,
        this.thumbnail,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        category: categoryValues.map[json["category"]]!,
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "category": categoryValues.reverse[category],
        "thumbnail": thumbnail,
    };
}

enum Category {
    BEAUTY,
    FRAGRANCES,
    FURNITURE,
    GROCERIES
}

final categoryValues = EnumValues({
    "beauty": Category.BEAUTY,
    "fragrances": Category.FRAGRANCES,
    "furniture": Category.FURNITURE,
    "groceries": Category.GROCERIES
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
