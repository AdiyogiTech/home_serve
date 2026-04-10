import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryOrange = Color(0xFFFF5722);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER SECTION
            Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
              decoration: BoxDecoration(
                color: primaryOrange.withOpacity(0.05),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                   Center(
                    child: Stack(
                      children: const [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: primaryOrange,
                          child: CircleAvatar(
                            radius: 52,
                            backgroundImage: NetworkImage("https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y"),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: primaryOrange,
                            child: Icon(Icons.edit, color: Colors.white, size: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text("Ankit Bansal", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text("ankit.bansal@example.com", style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                ],
              ),
            ),

            // MENU SECTION
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildMenuItem(Icons.person_outline, "Edit Profile", () {}),
                  _buildMenuItem(Icons.location_on_outlined, "My Addresses", () {}),
                  _buildMenuItem(Icons.payment_outlined, "Payment Methods", () {}),
                  _buildMenuItem(Icons.notifications_none_outlined, "Notifications", () {}),
                  _buildMenuItem(Icons.help_outline, "Support & Help", () {}),
                  _buildMenuItem(Icons.lock_outline, "Privacy Policy", () {}),
                  const SizedBox(height: 20),
                  _buildMenuItem(Icons.logout, "Logout", () {}, isLogout: true),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isLogout ? Colors.red.shade50.withOpacity(0.5) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ListTile(
        leading: Icon(icon, color: isLogout ? Colors.red : Colors.black87),
        title: Text(
          title,
          style: TextStyle(
            color: isLogout ? Colors.red : Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: isLogout ? Colors.red.withOpacity(0.5) : Colors.grey.shade400),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
