import 'package:bluxkart/constants/consts.dart';
import 'package:bluxkart/controllers/cart_controller.dart';
import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:bluxkart/views/Wigets_common/loading_indicator.dart';
import 'package:bluxkart/views/Wigets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../sevices/razorpay_service.dart';

class PaymentmethodScreen extends StatefulWidget {
  const PaymentmethodScreen({super.key});

  @override
  _PaymentmethodScreenState createState() => _PaymentmethodScreenState();
}

class _PaymentmethodScreenState extends State<PaymentmethodScreen> {
  var controller = Get.find<cartController>();
  final RazorpayService _razorpayService = RazorpayService();
  int selectedPaymentMethod = 0; // 0 = UPI, 1 = Card

  @override
  void dispose() {
    _razorpayService.dispose();
    super.dispose();
  }

  Widget buildPaymentOption({
    required String label,
    required String asset,
    required int index,
  }) {
    bool isSelected = selectedPaymentMethod == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.white.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 1,
              ),
          ],
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Image.asset(
              asset,
              width: context.screenWidth - 100,
              height: 150,
              fit: BoxFit.fill,
            ),
            if (isSelected)
              Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  activeColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  value: true,
                  onChanged: (_) {},
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: "Payment Method".text.white.bold.make(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Colors.transparent,
          child: controller.placingorder.value
              ? loadingIndicator()
              : ourButton(
            color: const Color(0xFF8E2DE2),
            onPress: () {
              String paymentMethod = selectedPaymentMethod == 0 ? "UPI" : "Card";
              _razorpayService.openCheckout(paymentMethod);
            },
            texTcolor: Colors.white,
            title: "Pay Now",
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              30.heightBox,
              buildPaymentOption(
                label: "UPI",
                asset: 'assets/images/img.png',
                index: 0,
              ),
              buildPaymentOption(
                label: "Card",
                asset: 'assets/images/img_3.png',
                index: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
