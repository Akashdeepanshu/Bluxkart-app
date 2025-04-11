import 'package:bluxkart/constants/consts.dart';
import 'package:bluxkart/constants/firebase_const.dart';
import 'package:bluxkart/constants/strings.dart' as profileController;
import 'package:bluxkart/controllers/auth_controller.dart';
import 'package:bluxkart/sevices/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:bluxkart/sevices/shiprocket_service.dart'; // Import Shiprocket API service
class cartController extends GetxController {
  var totalP = 0.obs;

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var zipcodeController = TextEditingController();
  var phoneController = TextEditingController();
  var placingorder = false.obs;
  var cancelorder = false.obs;
  var refunded = false.obs;






  var orderID = '1234567';

  var paymentIndex = 0.obs;
  List<String> paymentMethods = ["UPI", "Card", "Net Banking"];

  String get selectedPaymentMethod => paymentMethods[paymentIndex.value];

  late dynamic productsnapshot;
  var products = [];

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changepaymentIndex(index) {
    paymentIndex.value = index;
  }


  placemyOrder({required orderpaymentmethod, required totalAmount}) async {
    placingorder(true);
    await getproductsdetails();

    var userDoc = await firestore.collection(usersCollection).doc(currentuser!.uid).get();
    var userData = userDoc.data();

    var orderRef = firestore.collection(ordersCollection).doc();
    String orderId = orderRef.id;

    await orderRef.set({
      'order_code': orderId,
      'order_by': currentuser!.uid,
      'order_by_name': userData?['name'] ?? "Unknown User",
      'order_by_email': currentuser!.email ?? "No Email",
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_zipcode': zipcodeController.text,
      'order_by_phone': phoneController.text,
      'order_confirm': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'order_date': FieldValue.serverTimestamp(),
      'order_cancel': false,
      'order_placed': true,
      'order_refunded': false,
      'payment_method': orderpaymentmethod,
      'shipping_method': 'Standard',
      'order_total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products),
      'vendor': FieldValue.arrayUnion(products.map((e) => e['vendor_id']).toList()),
    });

    placingorder(false);
  }

  getproductsdetails() {
    products.clear();
    for (var i = 0; i < productsnapshot.length; i++) {
      products.add({
        'vendor_id': productsnapshot[i]['vendor_id'],
        'title': productsnapshot[i]['title'],
        'img': productsnapshot[i]['img'],
        'tprice': productsnapshot[i]['tprice'],
        'id': productsnapshot[i].id,
        'color': productsnapshot[i]['color'],
        'qty': productsnapshot[i]['qty'],
        'size': productsnapshot[i]['size'],
      });
    }
  }

  clearCart() async {
    if (productsnapshot.isNotEmpty) {
      await Future.wait(
        productsnapshot.map((product) {
          return firestore.collection(cartCollection).doc(product.id).delete();
        }),
      );
    }
  }

}
