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
      body: Obx(() => screens[dashboardController.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: dashboardController.selectedIndex.value,
          onTap: (index) => dashboardController.changeIndex(index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryOrange,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined), activeIcon: Icon(Icons.grid_view), label: "Services"),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), activeIcon: Icon(Icons.calendar_month), label: "Bookings"),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
