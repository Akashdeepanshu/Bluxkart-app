import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bluxkart/controllers/auth_controller.dart';
import 'package:bluxkart/constants/consts.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final authController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: const Text(
            "Forgot Password",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  "Enter your email to receive a reset link"
                      .text
                      .white
                      .size(18)
                      .semiBold
                      .center
                      .make(),
                  const SizedBox(height: 25),
                  TextField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: Colors.white10,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Gradient Button Wrapper
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8E2DE2), Colors.black],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton(
                      onPressed: () =>
                          controller.resetPasswordMethod(context: context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Send Reset Email",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
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
}
