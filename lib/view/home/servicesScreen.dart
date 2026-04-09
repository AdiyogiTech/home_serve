import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/homeController.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final Color primaryOrange = const Color(0xFFE65100);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("All Services", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What do you need help with?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Choose from our wide range of professional services", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: controller.services.length,
              itemBuilder: (context, index) {
                final service = controller.services[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(service['color']).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(_getIcon(service['icon']), color: Color(service['color']), size: 28),
                      ),
                      const SizedBox(height: 12),
                      Text(service['name'], 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'cleaning_services': return Icons.cleaning_services;
      case 'format_paint': return Icons.format_paint;
      case 'home_repair_service': return Icons.home_repair_service;
      case 'inventory_2': return Icons.inventory_2;
      case 'electrical_services': return Icons.electrical_services;
      case 'plumbing': return Icons.plumbing;
      case 'home': return Icons.home;
      case 'design_services': return Icons.design_services;
      default: return Icons.category;
    }
  }
}
