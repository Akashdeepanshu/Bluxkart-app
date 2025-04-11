import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AboutusScreen extends StatelessWidget {
  const AboutusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8E2DE2), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom AppBar
              AppBar(
                title: "About Us".text.white.bold.make(),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
              ),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Welcome to Bluxkart!"
                          .text
                          .white
                          .xl4
                          .bold
                          .make(),
                      10.heightBox,
                      "Everything you need to know about your favorite shopping destination."
                          .text
                          .white
                          .semiBold
                          .size(18)
                          .make(),
                      20.heightBox,

                      // Main description in a Card-style box
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "We create and curate stunning designs of your choice and print them on everything from t-shirts to hoodies and even socks! 🎨👕\n\n"
                                "Our funky products are crafted to spread happiness and good vibes—right down to your 'Bluxkart'. A (totally unbiased 😉) internal study shows shopping at www.bluxkart.com boosts happiness by 7.5%.\n\n"
                                "So if you're hunting for cool, customized fashion with great deals, you're already at the right place!"
                                .text
                                .white
                                .size(16)
                                .make(),
                          ],
                        ),
                      ),

                      30.heightBox,

                      // Contact section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Need Help?".text.white.xl2.bold.make(),
                          10.heightBox,
                          "For any queries regarding shipment or delivery, feel free to contact us at:"
                              .text
                              .white
                              .size(15)
                              .make(),
                          5.heightBox,
                          "📧 support@bluxkart.com"
                              .text
                              .white
                              .semiBold
                              .size(16)
                              .make(),
                        ],
                      ),
                      40.heightBox,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
