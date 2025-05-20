import 'package:bluxkart/constants/consts.dart';
import 'package:bluxkart/controllers/product_controller.dart';
import 'package:bluxkart/sevices/firestore_services.dart';
import 'package:bluxkart/views/Category_screen/item_details.dart';
import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:bluxkart/views/Wigets_common/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

class homeproductsall extends StatelessWidget{

  final String? title;
  const homeproductsall({super.key , required this.title});


  @override

  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    // print(int.parse((Colors.blueAccent) as String));
    return StreamBuilder(stream: FirestoreServices.getProducts(title) ,

        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }else if (snapshot.data!.docs.isEmpty){
            return Center(
              child: "No Product found".text.white.make(),
            );
          }else{

            var data = snapshot.data!.docs;



            return Container(
              height: 360,
              child: GridView.builder(
                  itemCount: data.length ,
                  shrinkWrap: true,

                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisExtent: 200,

                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 300,
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              data[index]['p_images'][0],
                              height: 250, // Adjusting image height
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8), // Space between image and text
                          "${data[index]["p_name"]}".text.color(Colors.white).fontWeight(FontWeight.bold).make(),
                              () {
                            final price = double.tryParse(data[index]["p_price"].toString()) ?? 0;
                            final discount = double.tryParse(data[index]["p_discount"].toString()) ?? 0;
                            final discountedPrice =  price - ((price * discount) ~/ 100);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (discount > 0)
                                  Row(
                                    children: [
                                      "\₹${price.toStringAsFixed(2)}"
                                          .text
                                          .lineThrough
                                          .color(Colors.redAccent)
                                          .size(13)
                                          .make(),
                                      6.widthBox,
                                      "-${discount.toInt()}%".text.color(Colors.orangeAccent).size(13).make(),
                                    ],
                                  ),
                                "\₹${discountedPrice.toStringAsFixed(2)}"
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
                    ).onTap(() {
                      controller.checkIfFav(data[index]);
                      Get.to(() => ItemDetails(title: "${data[index]["p_name"]}",data: data[index],));
                    });
                  }
              ),
            );

          }

        });


  }

}