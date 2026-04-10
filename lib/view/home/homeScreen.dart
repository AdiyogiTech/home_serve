import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemant_projects/constant/colors.dart';
import 'package:hemant_projects/constant/imagePaths.dart';
import 'controller/homeController.dart';
import 'controller/dashboardController.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final DashboardController dashboardController = Get.find<DashboardController>();
    const Color primaryOrange = Color(0xFFE65100);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.orange.shade50,
          child: SafeArea(
            bottom: false,
            child: Container(
              color: Colors.white, // Keep background white for content below header
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(ImagePath.homeServeLogo2, scale: 7),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.notifications_none, color: Colors.black, size: 22),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // AUTO-SLIDING BANNERS
                          _buildBannerSlider(controller, primaryOrange),

                          // HERO TITLE
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text:  TextSpan(
                                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black, height: 1.2),
                                    children: [
                                      TextSpan(text: "Hiring service\nexperts "),
                                      TextSpan(text: "made easy", style: TextStyle(color: AppColors.primaryColor)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  "From cleaning to repairs, painting to plumbing - connect with verified professionals and get quality work done at fair prices.",
                                  style: TextStyle(color: Colors.grey, fontSize: 11),
                                ),
                              ],
                            ),
                          ),

                          // LOCATION SELECTOR (Separate Box)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                            child: InkWell(
                              onTap: () {
                                _showLocationPicker(context, controller);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.location_on, color: AppColors.primaryColor, size: 18),
                                    const SizedBox(width: 8),
                                    Obx(() => Text(
                                      controller.selectedLocation.value,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                    )),
                                    const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 18),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // SEARCH BAR
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Search Hint Area
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: TextField(
                                        controller: controller.searchFieldController,
                                        decoration: InputDecoration(
                                          hintText: "What service do you need?",
                                          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                                          prefixIcon: Icon(Icons.search, color: Colors.grey.shade300, size: 22),
                                          border: InputBorder.none,
                                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Search/Clear Button
                                  Obx(() => InkWell(
                                    onTap: () {
                                      if (controller.searchQuery.value.isNotEmpty) {
                                        controller.searchFieldController.clear();
                                      } else {
                                        // Perform Search
                                        print("Search for: ${controller.searchFieldController.text}");
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      margin: const EdgeInsets.all(4),
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            controller.searchQuery.value.isNotEmpty ? Icons.close : Icons.search,
                                            color: Colors.white,
                                            size: 18
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            controller.searchQuery.value.isNotEmpty ? "Clear" : "Search",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                          // POPULAR TAGS
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            child: Row(
                              children: [
                                Text(
                                  "Popular: ",
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        _buildPopularChip("AC Repair"),
                                        _buildPopularChip("Deep Cleaning"),
                                        _buildPopularChip("Plumber"),
                                        _buildPopularChip("Electrician"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),



                          // SERVICES SECTION
                          _buildSectionHeader("Popular Services", () {
                            dashboardController.changeIndex(1);
                          }),
                          _buildServicesGrid(controller, dashboardController),

                          // HOW IT WORKS
                          _buildHowItWorksRoadmap(primaryOrange),
                          // TRUST STATS ROW
                          _buildTrustStats(),

                          // QUALITY ASSURANCES
                          _buildAssurances(),

                          // TOP RATED PROS
                          _buildSectionHeader("Best Rated Pros", () {}),
                          _buildProsHorizontalList(controller, primaryOrange),

                          // TESTIMONIALS
                          _buildSectionHeader("What Our Customers Say", () {}),
                          _buildTestimonialsSection(context, controller, primaryOrange),

                          const SizedBox(height: 110),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: onSeeAll,
            child: const Text("See All", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(HomeController controller, DashboardController dashboardController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.3,
        ),
        itemCount: 4, // Only first 4
        itemBuilder: (context, index) {
          final service = controller.services[index];
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(service['color']).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(_getIcon(service['icon']), color: Color(service['color']), size: 24),
                ),
                const SizedBox(height: 10),
                Text(service['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHowItWorksRoadmap(Color primaryOrange) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.orange.shade50.withOpacity(0.5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("How It Works", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          const Text("Get your service done in 4 simple steps", style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 40),
          _verticalRoadmapStep("1", Icons.search, "Search Service", "Browse through our wide range of home services.", true),
          _verticalRoadmapStep("2", Icons.person_search, "Choose Professional", "Select based on ratings, reviews and experience.", true),
          _verticalRoadmapStep("3", Icons.calendar_today, "Book & Schedule", "Pick a convenient time slot and confirm your booking.", true),
          _verticalRoadmapStep("4", Icons.thumb_up_off_alt, "Relax & Rate", "Enjoy quality service and share your feedback.", false),
        ],
      ),
    );
  }

  Widget _verticalRoadmapStep(String step, IconData icon, String title, String subtitle, bool showLine) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Center(child: Icon(icon, color: Colors.orange.shade800, size: 22)),
              ),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: Colors.orange.shade200,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Step $step: ", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.orange)),
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.4)),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProsHorizontalList(HomeController controller, Color primaryOrange) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: 4, 
        itemBuilder: (context, index) {
          final pro = controller.pros[index];
          final Color topColor = Color(pro['color']);
          
          return Container(
            width: 220,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 15, offset: const Offset(0, 5))
              ],
            ),
            child: Column(
              children: [
                // Top Colored Bar
                Container(
                  height: 65,
                  decoration: BoxDecoration(
                    color: topColor,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                ),
                
                // Centered Profile Avatar with Verification Badge
                Transform.translate(
                  offset: const Offset(0, -32),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.black,
                          child: Text(
                            pro['name'].split(' ').map((e) => e[0]).join(''),
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 20),
                        ),
                      ),
                    ],
                  ),
                ),

                // Professional's Details
                Transform.translate(
                  offset: const Offset(0, -20),
                  child: Column(
                    children: [
                      Text(pro['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 2),
                      Text(pro['category'], style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                      
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star, color: Color(0xFFFFB300), size: 16),
                          const SizedBox(width: 4),
                          Text("${pro['rating']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Text(" (234)", style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.access_time_filled, color: Colors.grey.shade400, size: 14),
                          const SizedBox(width: 4),
                          Text(pro['exp'], style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                          const SizedBox(width: 15),
                          Icon(Icons.workspace_premium_rounded, color: Colors.grey.shade400, size: 14),
                          const SizedBox(width: 4),
                          Text("1.2K+", style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                        ],
                      ),

                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Book Now",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _stepRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange, size: 20),
          const SizedBox(width: 15),
          Text(text, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildTestimonialsSection(BuildContext context, HomeController controller, Color primaryOrange) {
    final List<Map<String, dynamic>> enrichedReviews = [
      {
        "name": "Sneha Patel",
        "location": "Mumbai",
        "service": "House Cleaning",
        "review": "Booked a deep cleaning service and was amazed by the professionalism. The team was punctual, thorough, and left my home sparkling clean!",
      },
      {
        "name": "Vikram Singh",
        "location": "Bangalore",
        "service": "Electrical",
        "review": "Had an electrical emergency and HomeServe Pro connected me with a certified electrician within an hour. Excellent service and fair pricing.",
      },
      {
        "name": "Meera Nair",
        "location": "Chennai",
        "service": "Painting",
        "review": "The painting team did a fantastic job with our home renovation. They were neat, efficient, and the finish quality exceeded our expectations.",
      },
    ];

    return SizedBox(
      height: 270,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: enrichedReviews.length,
        itemBuilder: (context, index) {
          final review = enrichedReviews[index];
          return Container(
            width: 310,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade100),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 6))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.format_quote_rounded, color: Colors.orange.shade100, size: 45),
                const SizedBox(height: 10),
                Expanded(
                  child: Text(
                    "\"${review['review']}\"",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 13, height: 1.5, fontStyle: FontStyle.italic),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: primaryOrange,
                      child: Text(
                        review['name'].split(' ').map((e) => e[0]).join(''),
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(review['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text(review['location'], style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (i) => const Icon(Icons.star, color: Color(0xFFFFB300), size: 14),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(review['service'], style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPopularChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.blueGrey.shade700,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildBannerSlider(HomeController controller, Color primaryOrange) {
    final List<Map<String, dynamic>> banners = [
      {
        "title": "30% OFF\nFirst Booking",
        "subtitle": "Use Code: WELCOME30",
        "color": primaryOrange,
        "icon": Icons.local_offer_outlined
      },
      {
        "title": "Expert Deep\nCleaning",
        "subtitle": "Safe & Verified Pros",
        "color": const Color(0xFF1A237E),
        "icon": Icons.cleaning_services_outlined
      },
      {
        "title": "Home Repair\nEmergency?",
        "subtitle": "Pro within 60 mins",
        "color": const Color(0xFF1B5E20),
        "icon": Icons.bolt_outlined
      },
    ];

    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: PageView.builder(
        controller: controller.bannerController,
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [banner['color'], banner['color'].withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: banner['color'].withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))
              ],
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      banner['title'],
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.2),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      banner['subtitle'],
                      style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13),
                    ),
                  ],
                ),
                Positioned(
                  right: -10,
                  bottom: -10,
                  child: Icon(banner['icon'], size: 100, color: Colors.white.withOpacity(0.15)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrustStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildLargeStatItem(Icons.people_outline, "50,000+", "Happy Customers")),
              Container(width: 1, height: 40, color: Colors.grey.shade100),
              Expanded(child: _buildLargeStatItem(Icons.verified_user_outlined, "10,000+", "Verified Pros")),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Divider(color: Colors.grey.shade100, height: 1),
          ),
          Row(
            children: [
              Expanded(child: _buildLargeStatItem(Icons.star_outline, "4.8/5", "Average Rating")),
              Container(width: 1, height: 40, color: Colors.grey.shade100),
              Expanded(child: _buildLargeStatItem(Icons.timer_outlined, "30 min", "Avg Response")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLargeStatItem(IconData icon, String value, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.orange.shade800, size: 28),
        ),
        const SizedBox(height: 12),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(height: 30, width: 1, color: Colors.grey.shade100);
  }

  Widget _buildAssurances() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildAssuranceItem(Icons.shield_outlined, "Verified Professionals", "Background-checked experts")),
              Expanded(child: _buildAssuranceItem(Icons.verified_outlined, "Quality Guarantee", "100% satisfaction or money back")),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildAssuranceItem(Icons.access_time, "On-Time Service", "Punctual professionals, every time")),
              Expanded(child: _buildAssuranceItem(Icons.headset_mic_outlined, "24/7 Support", "Always here when you need us")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssuranceItem(IconData icon, String title, String sub) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.orange.shade800, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 9)),
            ],
          ),
        ),
      ],
    );
  }

  void _showLocationPicker(BuildContext context, HomeController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Select Location", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            ...controller.locations.map((loc) => ListTile(
              leading: Icon(Icons.location_on_outlined, color: AppColors.primaryColor),
              title: Text(loc, style: const TextStyle(fontWeight: FontWeight.w500)),
              onTap: () {
                controller.updateLocation(loc);
                Get.back();
              },
            )).toList(),
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
