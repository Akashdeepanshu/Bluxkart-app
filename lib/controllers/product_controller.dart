import 'package:bluxkart/constants/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  var quantity = 0.obs;
  var colorindex = 0.obs;
  var totalPrice = 0.obs;
  var isfav = false.obs;
  var selectedSize = "".obs;


  changeColorIndex(index) {
    var colorIndex = index;
  }

  changeSizeIndex(index) {
    var size = index;
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity)
    quantity.value++;
  }


  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;

  }
  addToCart({
    required String title,
    required String img,
    required String color,
    required int qty,
    required int tprice,
    required String size,
    required String vendorID,
  }) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'color': color,
      'qty': qty,
      'size': size,
      'vendor_id': vendorID,
      'tprice': tprice,
      'added_by': currentuser!.uid,
    }).catchError((error) {
      print("Error adding to cart: $error"); // Debugging
    });
  }

  resetValues(){
    totalPrice.value = 0;
    quantity.value = 0;
    colorindex.value = 0;
    selectedSize.value = "";


  }

  addToWishlist(String docId, BuildContext context) async {
    await firestore.collection(productsCollection).doc(docId).update({
      'p_wishlist': FieldValue.arrayUnion([currentuser!.uid])
    });

    isfav(true);
    VxToast.show(context, msg: "Added to Wishlist");
  }

  removeFromWishlist(String docId, BuildContext context) async {
    await firestore.collection(productsCollection).doc(docId).update({
      'p_wishlist': FieldValue.arrayRemove([currentuser!.uid])
    });

    isfav(false);
    VxToast.show(context, msg: "Removed from Wishlist");
  }
  checkIfFav(data)async{
    if(data['p_wishlist'].contains(currentuser!.uid)){
      isfav(true);
    }else{
      isfav(false);

    }
  }






}