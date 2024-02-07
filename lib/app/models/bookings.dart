// To parse this JSON data, do
//
//     final bookingResponse = bookingResponseFromJson(jsonString);

import 'dart:convert';

BookingResponse bookingResponseFromJson(String str) =>
    BookingResponse.fromJson(json.decode(str));

String bookingResponseToJson(BookingResponse data) =>
    json.encode(data.toJson());

class BookingResponse {
  final bool? success;
  final String? message;
  final List<Booking>? bookings;

  BookingResponse({
    this.success,
    this.message,
    this.bookings,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) =>
      BookingResponse(
        success: json["success"],
        message: json["message"],
        bookings: json["bookings"] == null
            ? []
            : List<Booking>.from(
                json["bookings"]!.map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "bookings": bookings == null
            ? []
            : List<dynamic>.from(bookings!.map((x) => x.toJson())),
      };
}

class Booking {
  final String? fullName;
  final String? email;
  final dynamic address;
  final String? bookingId;
  final String? userId;
  final String? vehicleId;
  final dynamic amount;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? categoryId;
  final String? perDayPrice;
  final String? category;

  Booking({
    this.fullName,
    this.email,
    this.address,
    this.bookingId,
    this.userId,
    this.vehicleId,
    this.amount,
    this.startDate,
    this.endDate,
    this.status,
    this.name,
    this.description,
    this.imageUrl,
    this.categoryId,
    this.perDayPrice,
    this.category,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        fullName: json["full_name"],
        email: json["email"],
        address: json["address"],
        bookingId: json["booking_id"],
        userId: json["user_id"],
        vehicleId: json["vehicle_id"],
        amount: json["amount"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        status: json["status"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
        categoryId: json["category_id"],
        perDayPrice: json["per_day_price"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "email": email,
        "address": address,
        "booking_id": bookingId,
        "user_id": userId,
        "vehicle_id": vehicleId,
        "amount": amount,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "category_id": categoryId,
        "per_day_price": perDayPrice,
        "category": category,
      };
}
