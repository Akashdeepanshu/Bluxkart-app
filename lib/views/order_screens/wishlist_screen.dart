import 'package:bluxkart/constants/consts.dart';
import 'package:bluxkart/controllers/cart_controller.dart';
import 'package:bluxkart/sevices/firestore_services.dart';
import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:bluxkart/views/Wigets_common/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class wishlistScreen extends StatelessWidget {
  const wishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(cartController());

    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: "Your Wishlist".text.white.make(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: StreamBuilder(
          stream: FirestoreServices.wishlist(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: loadingIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Your wishlist is empty!".text.white.size(18).make(),
              );
            } else {
              var data = snapshot.data!.docs;

              return ListView.builder(
                itemCount: data.length,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemBuilder: (BuildContext context, int index) {
                  var product = data[index];

                  return Card(
                    color: Colors.white10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product['p_images'][0],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, color: Colors.white),
                        ),
                      ),
                      title: product['p_name'].toString().text.white.lg.semiBold.make(),
                      subtitle: "${product['p_price']}".numCurrency.text.orange400.make(),
                      trailing: Icon(Icons.favorite, color: Colors.red).onTap(() {
                        firestore
                            .collection(productsCollection)
                            .doc(product.id)
                            .set({
                          'p_wishlist': FieldValue.arrayRemove([currentuser!.uid])
                        }, SetOptions(merge: true));
                      }),
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
