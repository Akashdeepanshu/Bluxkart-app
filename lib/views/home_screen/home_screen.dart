import 'package:bluxkart/constants/consts.dart';
import 'package:bluxkart/constants/lists.dart';
import 'package:bluxkart/views/home_screen/Newdrops.dart';
import 'package:bluxkart/views/home_screen/productsbysubcat.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8E2DE2), Colors.black],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: context.screenHeight,
      width: context.screenWidth,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                "assets/Logo/Main_logo-removebg-preview.png",
                height: 100,
              ).scale200(),

              // Tagline
              Text(
                "You Demand,\nWe Print",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              20.heightBox,

              // Promotional Message
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: Text(
                  "🔥 Unleash your creativity with custom prints!",
                  style: TextStyle(
                    color: Colors.amberAccent.shade100,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Product Sections
              _buildSectionTitle(newdrop),
              homeproducts(title: "newdrops"),

              _buildSectionTitle(bestsellers),
              homeproducts(title: "bestseller"),

              _buildSectionTitle("T-Shirts"),
              homeproductsall(title: "T-shirts"),

              _buildSectionTitle("Mugs"),
              homeproductsall(title: "Mugs"),

              _buildSectionTitle("Bags"),
              homeproductsall(title: "Bags"),

              _buildSectionTitle("Caps"),
              homeproductsall(title: "Caps"),

              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }

  // Section title widget with consistent style
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 28,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
