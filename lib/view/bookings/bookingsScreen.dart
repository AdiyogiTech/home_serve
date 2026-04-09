import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryOrange = Color(0xFFFF5722);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Bookings", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildBookingCard(index, primaryOrange);
        },
      ),
    );
  }

  Widget _buildBookingCard(int index, Color primaryOrange) {
    final List<Map<String, String>> dummyBookings = [
      {"service": "AC Repairing", "date": "12 Oct, 10:30 AM", "status": "Upcoming", "price": "\$49.00"},
      {"service": "Deep Cleaning", "date": "08 Oct, 02:00 PM", "status": "Completed", "price": "\$120.00"},
      {"service": "Full House Painting", "date": "01 Oct, 09:00 AM", "status": "Completed", "price": "\$850.00"},
    ];

    final booking = dummyBookings[index];
    final bool isUpcoming = booking['status'] == "Upcoming";

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 5))
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(Icons.build_circle_outlined, color: primaryOrange),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking['service']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(booking['date']!, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: isUpcoming ? Colors.blue.shade50 : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      booking['status']!,
                      style: TextStyle(
                        color: isUpcoming ? Colors.blue : Colors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(booking['price']!, style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: primaryOrange)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text("View Details", style: TextStyle(color: Colors.grey, fontSize: 13)),
              ),
              if (isUpcoming)
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryOrange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: const Text("Reschedule", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                )
              else
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side:  BorderSide(color: primaryOrange),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child:  Text("Book Again", style: TextStyle(color: primaryOrange, fontSize: 13, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
