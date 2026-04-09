import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedLocation = "Bangalore".obs;
  var locations = ["Bangalore", "Mumbai", "Delhi", "Hyderabad", "Pune"];
  final searchFieldController = TextEditingController();
  final bannerController = PageController();
  var searchQuery = "".obs;
  var currentBannerIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    searchFieldController.addListener(() {
      searchQuery.value = searchFieldController.text;
    });
    
    // Auto-slide Banners
    _startBannerTimer();
  }

  void _startBannerTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (bannerController.hasClients) {
        currentBannerIndex.value = (currentBannerIndex.value + 1) % 3;
        bannerController.animateToPage(
          currentBannerIndex.value,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _startBannerTimer();
      }
    });
  }

  @override
  void onClose() {
    bannerController.dispose();
    super.onClose();
  }

  void updateLocation(String location) {
    selectedLocation.value = location;
  }

  List<Map<String, dynamic>> services = [
    {"name": "Cleaning", "icon": "cleaning_services", "color": 0xFF2196F3},
    {"name": "Painting", "icon": "format_paint", "color": 0xFFFF9800},
    {"name": "Appliance", "icon": "home_repair_service", "color": 0xFF4CAF50},
    {"name": "Packing", "icon": "inventory_2", "color": 0xFFE91E63},
    {"name": "Electrical", "icon": "electrical_services", "color": 0xFFFFC107},
    {"name": "Plumbing", "icon": "plumbing", "color": 0xFF00BCD4},
    {"name": "Home Renovation", "icon": "home", "color": 0xFFFF5722},
    {"name": "Interior Design", "icon": "design_services", "color": 0xFF673AB7},
  ];

  List<Map<String, dynamic>> pros = [
    {
      "name": "Rajesh Kumar",
      "category": "Plumbing",
      "rating": 4.8,
      "exp": "5 Years",
      "color": 0xFFFF9800,
    },
    {
      "name": "Vijay Sharma",
      "category": "House Painting",
      "rating": 4.9,
      "exp": "8 Years",
      "color": 0xFF2196F3,
    },
    {
      "name": "Mohammad Ali",
      "category": "Electrician",
      "rating": 4.7,
      "exp": "6 Years",
      "color": 0xFF00BCD4,
    },
    {
      "name": "Anita Rani",
      "category": "Painting",
      "rating": 4.8,
      "exp": "4 Years",
      "color": 0xFFE91E63,
    },
  ];

  List<Map<String, dynamic>> reviews = [
    {
      "name": "Aniket Patel",
      "review": "Excellent work by the professional. Highly recommend for any home services.",
      "rating": 5,
    },
    {
      "name": "Vikram Singh",
      "review": "Very satisfied with the appliance repair service. Prompt and expert advice.",
      "rating": 5,
    },
    {
      "name": "Simran Kaur",
      "review": "Best experience with home painting. The team was professional and clean.",
      "rating": 5,
    },
  ];
}
