import 'package:bluxkart/constants/consts.dart';
import 'package:bluxkart/controllers/cart_controller.dart';
import 'package:bluxkart/sevices/firestore_services.dart';
import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:bluxkart/views/Wigets_common/loading_indicator.dart';
import 'package:bluxkart/views/order_screens/orderDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class orderScreen extends StatelessWidget {
  const orderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(cartController());

    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: "Your Orders".text.white.make(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getOrders(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: loadingIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(child: "No Orders Yet!".text.white.make());
            } else {
              var data = snapshot.data!.docs;

              return ListView.builder(
                itemCount: data.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (BuildContext context, int index) {
                  var order = data[index];

                  String statusText = "Pending";
                  Color statusColor = Colors.orangeAccent;
                  IconData statusIcon = Icons.access_time;

                  if (order['order_refunded'] == true) {
                    statusText = "Refunded";
                    statusColor = Colors.greenAccent;
                    statusIcon = Icons.refresh;
                  } else if (order['order_delivered'] == true) {
                    statusText = "Delivered";
                    statusColor = Colors.green;
                    statusIcon = Icons.check_circle;
                  } else if (order['order_cancel'] == true) {
                    statusText = "Canceled";
                    statusColor = Colors.redAccent;
                    statusIcon = Icons.cancel;
                  } else if (order['order_on_delivery'] == true) {
                    statusText = "On Delivery";
                    statusColor = Colors.yellowAccent;
                    statusIcon = Icons.delivery_dining;
                  } else if (order['order_confirm'] == true) {
                    statusText = "Confirmed";
                    statusColor = Colors.blueAccent;
                    statusIcon = Icons.verified;
                  }

                  return InkWell(
                    onTap: () {
                      Get.to(() => orderDETAILS(data: order));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: statusColor.withOpacity(0.3),
                            radius: 24,
                            child: Icon(statusIcon, color: statusColor),
                          ),
                          16.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Order #${order['order_code']}".text.white.semiBold.size(16).make(),
                                6.heightBox,
                                statusText.text.color(statusColor).bold.make(),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
