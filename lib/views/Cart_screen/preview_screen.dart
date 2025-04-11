import 'package:bluxkart/constants/consts.dart';
import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:bluxkart/views/Wigets_common/our_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../sevices/firestore_services.dart';
import 'PaymentMethod_screen.dart';

class previewScreen extends StatefulWidget {
  final dynamic data;
  const previewScreen({super.key, this.data});

  @override
  State<previewScreen> createState() => _previewScreenState();
}

class _previewScreenState extends State<previewScreen> {
  String name = "";
  String email = "";
  var controller = Get.put(cartController());

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  void fetchUserDetails() async {
    var userDoc = await firestore.collection(usersCollection).doc(currentuser!.uid).get();
    var userData = userDoc.data();
    setState(() {
      name = userData?['name'] ?? "Unknown";
      email = currentuser!.email ?? "No Email";
    });
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: "Preview Order".text.white.bold.make(),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ourButton(
            color: const Color(0xFF8E2DE2),
            onPress: () => Get.to(() => PaymentmethodScreen()),
            texTcolor: Colors.white,
            title: "Place Order",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shipping Info
                Card(
                  color: Colors.black.withOpacity(0.7),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Shipping Address".text.white.bold.size(18).make(),
                        10.heightBox,
                        "$name".text.white.make(),
                        "$email".text.white.make(),
                        "${widget.data['address']}".text.white.make(),
                        "${widget.data['city']}".text.white.make(),
                        "${widget.data['state']}".text.white.make(),
                        "Pincode: ${widget.data['zipcode']}".text.white.make(),
                        "Phone: ${widget.data['phone']}".text.white.make(),
                      ],
                    ),
                  ),
                ),
                20.heightBox,

                // Total Amount
                Card(
                  color: Colors.black.withOpacity(0.7),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Total Amount".text.white.bold.size(18).make(),
                        10.heightBox,
                        "₹${widget.data['totalAmount']}".text.white.extraBold.size(24).make(),
                      ],
                    ),
                  ),
                ),
                20.heightBox,

                // Ordered Products
                "Ordered Products".text.white.extraBold.size(20).make(),
                10.heightBox,
                StreamBuilder(
                  stream: FirestoreServices.getCart(currentuser!.uid),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      var data = snapshot.data!.docs;
                      controller.productsnapshot = data;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        controller.calculate(data);
                      });

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: Row(
                              children: [
                                Image.network(
                                  "${data[index]['img']}",
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ).box.rounded.clip(Clip.antiAlias).make(),
                                12.widthBox,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "${data[index]['title']}".text.white.bold.make(),
                                      "Size: ${data[index]['size']}".text.white.make(),
                                      "Qty: ${data[index]['qty']}".text.white.make(),
                                      "₹${data[index]['tprice']}".text.white.make(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
