import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bookings/bookingsScreen.dart';
import '../profile/profileScreen.dart';
import 'controller/dashboardController.dart';
import 'homeScreen.dart';
import 'servicesScreen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboardController = Get.put(DashboardController());
    const Color primaryOrange = Color(0xFFFF5722);

    final List<Widget> screens = [
      const HomeScreen(),
      const ServicesScreen(),
      const BookingsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Obx(() => screens[dashboardController.selectedIndex.value]),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: primaryOrange.withOpacity(0.2), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Obx(
            () => BottomNavigationBar(
              currentIndex: dashboardController.selectedIndex.value,
              onTap: (index) => dashboardController.changeIndex(index),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: primaryOrange,
              unselectedItemColor: Colors.grey.shade400,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              backgroundColor: Colors.white,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_rounded), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined), activeIcon: Icon(Icons.grid_view_rounded), label: "Services"),
                BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), activeIcon: Icon(Icons.calendar_month_rounded), label: "Bookings"),
                BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person_rounded), label: "Profile"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
