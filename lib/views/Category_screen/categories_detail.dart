import 'package:bluxkart/constants/consts.dart';
import 'package:bluxkart/controllers/product_controller.dart';
import 'package:bluxkart/sevices/firestore_services.dart';
import 'package:bluxkart/views/Category_screen/item_details.dart';
import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:bluxkart/views/Wigets_common/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetail extends StatelessWidget {
  final String? title;
  const CategoryDetail({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());



    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: title!.text.white.xl2.bold.make(),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getProducts(title),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: loadingIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "No Products Found"
                    .text
                    .white
                    .xl
                    .bold
                    .make()
                    .box
                    .rounded
                    .color(Colors.black45)
                    .p16
                    .makeCentered(),
              );
            } else {
              var data = snapshot.data!.docs;



              return GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: data.length,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  mainAxisExtent: 270,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.checkIfFav(data[index]);
                      Get.to(() => ItemDetails(
                        title: data[index]["p_name"],
                        data: data[index],
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(2, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: Image.network(
                              data[index]['p_images'][0],
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                data[index]["p_name"]
                                    .toString()
                                    .text
                                    .white
                                    .fontWeight(FontWeight.w600)
                                    .maxLines(1)
                                    .ellipsis
                                    .size(16)
                                    .make(),
                                4.heightBox,
                                    () {
                                  final price = double.tryParse(data[index]["p_price"].toString()) ?? 0;
                                  final discount = double.tryParse(data[index]["p_discount"].toString()) ?? 0;
                                  final discountedPrice = price - ((price * discount) ~/ 100);

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (discount > 0)
                                        Row(
                                          children: [
                                            "\$${price.toStringAsFixed(2)}"
                                                .text
                                                .lineThrough
                                                .color(Colors.redAccent)
                                                .size(13)
                                                .make(),
                                            6.widthBox,
                                            "-${discount.toInt()}%".text.color(Colors.orangeAccent).size(13).make(),
                                          ],
                                        ),
                                      "\$${discountedPrice.toStringAsFixed(2)}"
                                          .text
                                          .color(Colors.greenAccent)
                                          .semiBold
                                          .size(15)
                                          .make(),
                                    ],
                                  );
                                }(),

                              ],
                            ),
                          )
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
