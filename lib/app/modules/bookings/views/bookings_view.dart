import 'package:ecom_5/app/models/bookings.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/bookings_controller.dart';

class BookingsView extends GetView<BookingsController> {
  const BookingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(BookingsController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('BookingsView'),
          centerTitle: true,
        ),
        body: GetBuilder<BookingsController>(
          builder: (controller) {
            if (controller.bookingResponse == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                await controller.getBookings();
              },
              child: ListView.builder(
                itemCount: controller.bookingResponse!.bookings!.length,
                itemBuilder: (context, index) {
                  return BookingCard(
                      booking: controller.bookingResponse!.bookings![index]);
                },
              ),
            );
          },
        ));
  }
}

class BookingCard extends StatelessWidget {
  final Booking booking;
  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
        bottom: 20,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(booking.name ?? '',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text(
                          DateFormat('yyyy-MMMM-dd').format(booking.startDate!),
                          style: const TextStyle(fontSize: 16)),
                      const Text(' - '),
                      Text(DateFormat('MMMM-dd').format(booking.endDate!),
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
              Text(
                booking.status?.toUpperCase() ?? '',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: booking.status == 'pending'
                      ? Colors.orange
                      : booking.status == 'success'
                          ? Colors.green
                          : Colors.red,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Text(
                booking.amount == null
                    ? "-"
                    : "Rs.${(double.parse(booking.amount!) / 100).toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Text(
                "Booking ID: ${booking.bookingId?.toUpperCase() ?? ''}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Text(
                "Booked by: ${booking.fullName?.toUpperCase() ?? ''} (${booking.email ?? ''})",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
