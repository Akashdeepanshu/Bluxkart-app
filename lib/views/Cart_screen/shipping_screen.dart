import 'package:bluxkart/constants/consts.dart';
import 'package:bluxkart/controllers/cart_controller.dart';
import 'package:bluxkart/views/Cart_screen/preview_screen.dart';
import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:bluxkart/views/Wigets_common/custom_Textfield.dart';
import 'package:bluxkart/views/Wigets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<cartController>();

    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: "Shipping Details".text.white.semiBold.make(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
              controller.addressController.clear();
              controller.cityController.clear();
              controller.stateController.clear();
              controller.zipcodeController.clear();
              controller.phoneController.clear();
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ourButton(
            color: const Color(0xFF8E2DE2),
            texTcolor: Colors.white,
            title: "Continue",
            onPress: () {
              final valid = controller.addressController.text.length > 5 &&
                  controller.cityController.text.length > 2 &&
                  controller.stateController.text.length > 2 &&
                  controller.zipcodeController.text.length >= 6 &&
                  controller.phoneController.text.length == 10;

              if (valid) {
                Get.to(() => previewScreen(data: {
                  'address': controller.addressController.text,
                  'city': controller.cityController.text,
                  'state': controller.stateController.text,
                  'zipcode': controller.zipcodeController.text,
                  'phone': controller.phoneController.text,
                  'payment': controller.selectedPaymentMethod,
                  'totalAmount': controller.totalP.value.toString(),
                }));
              } else {
                VxToast.show(context, msg: "Please fill all fields correctly");
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            color: Colors.black.withOpacity(0.6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  "Enter your delivery information"
                      .text
                      .white
                      .semiBold
                      .size(18)
                      .make()
                      .box
                      .margin(const EdgeInsets.only(bottom: 12))
                      .make(),

                  customTextField(
                    hint: 'House no / Street / Area',
                    isPass: false,
                    title: 'Address',
                    controller: controller.addressController,
                  ),
                  10.heightBox,
                  customTextField(
                    hint: 'City',
                    isPass: false,
                    title: 'City',
                    controller: controller.cityController,
                  ),
                  10.heightBox,
                  customTextField(
                    hint: 'State',
                    isPass: false,
                    title: 'State',
                    controller: controller.stateController,
                  ),
                  10.heightBox,
                  customTextField(
                    hint: 'Zip Code',
                    isPass: false,
                    title: 'Zip Code',
                    controller: controller.zipcodeController,
                  ),
                  10.heightBox,
                  customTextField(
                    hint: 'Phone Number',
                    isPass: false,
                    title: 'Phone Number',
                    controller: controller.phoneController,
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
