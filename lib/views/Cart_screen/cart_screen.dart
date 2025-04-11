import 'package:bluxkart/constants/consts.dart';
import 'package:bluxkart/controllers/cart_controller.dart';
import 'package:bluxkart/sevices/firestore_services.dart';
import 'package:bluxkart/views/Cart_screen/shipping_screen.dart';
import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:bluxkart/views/Wigets_common/loading_indicator.dart';
import 'package:bluxkart/views/Wigets_common/our_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(cartController());
    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shopping Cart".text.white.bold.make(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getCart(currentuser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: loadingIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Your cart is empty 🛒".text.white.size(18).semiBold.make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.productsnapshot = data;
              controller.calculate(data);

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    "${data[index]['img']}",
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                12.widthBox,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "${data[index]['title']}"
                                          .text
                                          .white
                                          .semiBold
                                          .size(16)
                                          .make(),
                                      "${data[index]['tprice']}"
                                          .numCurrency
                                          .text
                                          .color(Colors.white60)
                                          .make(),
                                    ],
                                  ),
                                ),
                                Icon(Icons.delete, color: Colors.redAccent)
                                    .onTap(() => FirestoreServices.deleteDocument(data[index].id)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(color: Colors.white30),
                    10.heightBox,

                    // Total + Checkout
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Total Price".text.white.semiBold.size(18).make(),
                              Obx(() => "${controller.totalP.value}"
                                  .numCurrency
                                  .text
                                  .white
                                  .semiBold
                                  .size(18)
                                  .make()),
                            ],
                          ),
                          20.heightBox,
                          ourButton(
                            color: const Color(0xFF8E2DE2),
                            onPress: () {
                              Get.to(() => const ShippingDetails());
                            },
                            texTcolor: Colors.white,
                            title: "Proceed to Checkout",
                          ).box.width(context.screenWidth).make(),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
