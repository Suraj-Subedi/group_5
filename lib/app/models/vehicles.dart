// To parse this JSON data, do
//
//     final vehiclesResponse = vehiclesResponseFromJson(jsonString);

import 'dart:convert';

VehiclesResponse vehiclesResponseFromJson(String str) =>
    VehiclesResponse.fromJson(json.decode(str));

String vehiclesResponseToJson(VehiclesResponse data) =>
    json.encode(data.toJson());

class VehiclesResponse {
  final bool? success;
  final String? message;
  final List<Vehicle>? vehicles;

  VehiclesResponse({
    this.success,
    this.message,
    this.vehicles,
  });

  factory VehiclesResponse.fromJson(Map<String, dynamic> json) =>
      VehiclesResponse(
        success: json["success"],
        message: json["message"],
        vehicles: json["vehicles"] == null
            ? []
            : List<Vehicle>.from(
                json["vehicles"]!.map((x) => Vehicle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "vehicles": vehicles == null
            ? []
            : List<dynamic>.from(vehicles!.map((x) => x.toJson())),
      };
}

class Vehicle {
  final String? fullName;
  final String? email;
  final dynamic address;
  final String? vehicleId;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? categoryId;
  final String? perDayPrice;
  final String? userId;
  final String? category;

  Vehicle({
    this.fullName,
    this.email,
    this.address,
    this.vehicleId,
    this.name,
    this.description,
    this.imageUrl,
    this.categoryId,
    this.perDayPrice,
    this.userId,
    this.category,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        fullName: json["full_name"],
        email: json["email"],
        address: json["address"],
        vehicleId: json["vehicle_id"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
        categoryId: json["category_id"],
        perDayPrice: json["per_day_price"],
        userId: json["user_id"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "email": email,
        "address": address,
        "vehicle_id": vehicleId,
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "category_id": categoryId,
        "per_day_price": perDayPrice,
        "user_id": userId,
        "category": category,
      };
}
