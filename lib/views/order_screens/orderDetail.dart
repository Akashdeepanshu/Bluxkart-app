import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:bluxkart/views/order_screens/COMPONENT/order_placed_details.dart';
import 'package:bluxkart/views/order_screens/COMPONENT/order_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

import '../../constants/colors.dart';
import '../../constants/firebase_const.dart';
import '../../controllers/cart_controller.dart';

class orderDETAILS extends StatefulWidget {
  final dynamic data;
  const orderDETAILS({super.key, this.data});

  @override
  _orderDETAILSState createState() => _orderDETAILSState();
}

class _orderDETAILSState extends State<orderDETAILS> {

  var controller = Get.put(cartController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.cancelorder.value = widget.data['order_cancel'];
    controller.refunded.value = widget.data['order_refunded'];
  }

  @override
  Widget build(BuildContext context) {

    Color parseColor(String colorString) {
      try {
        return Color(int.parse("0x$colorString"));
      } catch (e) {
        print("Color parse failed: $colorString");
        return Colors.grey;
      }
    }
    
    return bgWidget(
      child: Obx(()=>
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: "Order Details".text.white.make(),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          bottomNavigationBar: Visibility(
            visible: !controller.cancelorder.value,
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Confirm Cancel"),
                      content: Text("Are you sure you want to cancel this order?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("No"),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.cancelorder.value = true;
                            firestore.collection(ordersCollection).doc(widget.data.id).update({
                              'order_cancel': true,
                            });
                            Navigator.pop(context); // Close dialog
                          },
                          child: Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
                child: "Cancel Order".text.bold.color(Colors.white).make(),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),
          ),

          body: Obx(()=>
             Padding(
              padding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        if (controller.cancelorder.value && controller.refunded.value)
                          Column(
                            children: [
                              Center(child: Icon(Icons.currency_rupee_rounded, color: Colors.green, size: 250)),
                              "Refunded".text.bold.green500.size(18).make(),
                            ],
                          )
                        else if (controller.cancelorder.value && !controller.refunded.value)
                          Column(
                            children: [
                              Center(child: Icon(Icons.cancel_outlined, color: Colors.red, size: 250)),
                              "Refund will be processed within 5–7 business days.".text.bold.green500.size(16).make(),
                            ],
                          )
                        else
                          Column(
                            children: [
                              orderStatus(
                                icon: Icons.done,
                                color: Colors.green,
                                title: "Placed",
                                showDone: widget.data['order_placed'],
                              ),
                              5.heightBox,
                              orderStatus(
                                icon: Icons.thumb_up_alt_sharp,
                                color: Colors.blueAccent,
                                title: "Confirmed",
                                showDone: widget.data['order_confirm'],
                              ),
                              5.heightBox,
                              orderStatus(
                                icon: Icons.directions_bus_filled,
                                color: Colors.yellowAccent,
                                title: "Delivery",
                                showDone: widget.data['order_on_delivery'],
                              ),
                              5.heightBox,
                              orderStatus(
                                icon: Icons.done_all_rounded,
                                color: Colors.green,
                                title: "Delivered",
                                showDone: widget.data['order_delivered'],
                              ),
                            ],
                          ),
                      ],
                    ),

                    Divider(thickness: 0.5, color: Colors.white24),


                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Shipping Address".text.white.bold.lg.make(),
                              4.heightBox,
                              "${widget.data['order_by_name']}".text.white.make(),
                              "${widget.data['order_by_email']}".text.white.make(),
                              "${widget.data['order_by_address']}".text.white.make(),
                              "${widget.data['order_by_city']}".text.white.make(),
                              "${widget.data['order_by_state']}".text.white.make(),
                              "${widget.data['order_by_zipcode']}".text.white.make(),
                              "${widget.data['order_by_phone']}".text.white.make(),
                            ],
                          ),
                          10.widthBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              "Total Amount".text.white.bold.make(),
                              "${widget.data['order_total_amount']}".text.white.bold.xl.make(),
                            ],
                          )
                        ],
                      ),
                    ),

                    Divider(thickness: 0.5, color: Colors.white24),



                    "Ordered Products".text.size(18).white.bold.make(),
                    10.heightBox,
                    ListView(
                      shrinkWrap: true,
                      children: List.generate(widget.data['orders'].length, (index) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              widget.data['orders'][index]['img'],
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: "${widget.data['orders'][index]['title']} (${widget.data['orders'][index]['size']})"
                              .text.white.semiBold.make(),
                          subtitle: "${widget.data['orders'][index]['qty']}x".text.white.make(),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              "${widget.data['orders'][index]['tprice']}".numCurrency.text.size(16).white.bold.make(),
                              6.heightBox,
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: parseColor(widget.data['orders'][index]['color']),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.white54),
                                ),
                              )
                            ],
                          ),
                        );




                        //   orderPlacedDetails(
                        //   widget.data['orders'][index]['title'],
                        //   widget.data['orders'][index]['size'],
                        //   "${widget.data['orders'][index]['qty']}x",
                        //   widget.data['orders'][index]['tprice'],
                        // );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}