// import 'package:flutter/material.dart';
// import 'package:flutter_braintree/flutter_braintree.dart';
// import 'package:get/get.dart';
// import '../controllers/cart_controller.dart';
// import '../views/home_screen/home.dart';
//
// class PayPalService {
//   final cartController controller = Get.find<cartController>();
//
//   // Your Braintree tokenization key (replace this with your actual key)
//   final String tokenizationKey = "sandbox_xxxxxxxx_xxxxxx_xxxxxx_xxxxxx";
//
//   Future<void> processPayment() async {
//     try {
//       // Create a PayPal request
//       var request = BraintreePayPalRequest(
//         amount: controller.totalP.value.toStringAsFixed(2),
//         currencyCode: "USD",
//         displayName: "BluxKart",
//       );
//
//       // Request PayPal payment nonce
//       BraintreePaymentMethodNonce? result =
//       await Braintree.requestPaypalNonce(tokenizationKey, request);
//
//       if (result != null) {
//         print("✅ PayPal Payment Successful: ${result.nonce}");
//
//         // Place order in your system
//         await controller.placemyOrder(
//             orderpaymentmethod: "PayPal", totalAmount: controller.totalP.value);
//         await controller.clearCart();
//
//         Get.snackbar("Payment Success", "Your order has been placed successfully",
//             colorText: Colors.white, backgroundColor: Colors.green);
//         Get.offAll(Home());
//       } else {
//         Get.snackbar("Payment Canceled", "You canceled the PayPal payment",
//             colorText: Colors.white, backgroundColor: Colors.orange);
//       }
//     } catch (e) {
//       print("❌ PayPal Payment Failed: $e");
//       Get.snackbar("Payment Failed", "Something went wrong",
//           colorText: Colors.white, backgroundColor: Colors.red);
//     }
//   }
// }
