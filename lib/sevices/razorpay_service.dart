import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../views/home_screen/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RazorpayService {
  final Razorpay _razorpay = Razorpay();
  final cartController controller = Get.find<cartController>();

  RazorpayService() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();
        return userDoc.data() as Map<String, dynamic>?;
      }
    } catch (e) {
      print("⚠️ Error fetching user data: $e");
    }
    return null;
  }

  void openCheckout(String paymentMethod) async {
    double amount = controller.totalP.value * 100; // Convert to paise

    if (amount <= 0) {
      Get.snackbar("Payment Error", "Total amount is zero. Add items to cart.",
          colorText: Colors.white, backgroundColor: Colors.red);
      return;
    }

    Map<String, dynamic>? userData = await getUserData();
    String contact = userData?['phone'] ?? "9876543210";
    String email = userData?['email'] ?? "user@example.com";

    var options = {
      "key": "rzp_test_XXXXXXXX",
      "amount": amount.toInt(),
      "currency": "INR",
      "name": "BluxKart",
      "description": "Order Payment",
      "prefill": {
        "contact": contact,
        "email": email,
      },
      "method": {
        "upi": paymentMethod == "UPI",
        "card": paymentMethod == "Card",
      },
      "theme": {
        "color": "#3399cc"
      }
    };

    try {
      _razorpay.open(options);
    } catch (e, stacktrace) {
      print("❌ Razorpay Error: $e");
      print("🔍 Stacktrace: $stacktrace");
      Get.snackbar("Payment Error", "Failed to open Razorpay checkout.",
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("✅ Payment Successful: ${response.paymentId}");

    await controller.placemyOrder(
      orderpaymentmethod: "Razorpay",
      totalAmount: controller.totalP.value,
    );

    await controller.clearCart();

    Get.snackbar(
      "Payment Success",
      "Your order has been placed successfully!",
      colorText: Colors.white,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    );

    await Future.delayed(const Duration(seconds: 2));
    Get.offAll(() => Home());
  }


  void _handlePaymentError(PaymentFailureResponse response) {
    print("❌ Payment Failed: ${response.message}");
    Get.snackbar("Payment Failed", "Transaction failed. Please try again.",
        colorText: Colors.white, backgroundColor: Colors.red);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("🔹 External Wallet: ${response.walletName}");
    Get.snackbar("External Wallet", "Payment made using ${response.walletName}",
        colorText: Colors.white, backgroundColor: Colors.orange);
  }

  void dispose() {
    _razorpay.clear();
  }
}
