// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

CategoryResponse categoryResponseFromJson(String str) =>
    CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) =>
    json.encode(data.toJson());

class CategoryResponse {
  final bool? success;
  final List<Category>? categories;

  CategoryResponse({
    this.success,
    this.categories,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        success: json["success"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class Category {
  final String? categoryId;
  final String? category;
  final String? isDeleted;

  Category({
    this.categoryId,
    this.category,
    this.isDeleted,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        category: json["category"],
        isDeleted: json["is_deleted"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category": category,
        "is_deleted": isDeleted,
      };
}
