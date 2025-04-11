import 'package:bluxkart/constants/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {

  static Stream<QuerySnapshot> getUser(String uid) {
    return firestore.collection(usersCollection).where('id', isEqualTo: uid).snapshots();
  }

  static updateUserCount(String uid) async {
    var cartSnap = await FirebaseFirestore.instance.collection('cart').where('added_by', isEqualTo: uid).get();
    var wishSnap = await FirebaseFirestore.instance.collection('wishlist').where('added_by', isEqualTo: uid).get();
    var orderSnap = await FirebaseFirestore.instance.collection('orders').where('order_by', isEqualTo: uid).get();

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'cart_count': cartSnap.docs.length,
      'wishlist_count': wishSnap.docs.length,
      'order_count': orderSnap.docs.length,
    });
  }




  static getProducts(category){
    return firestore.collection(productsCollection).where('p_category',isEqualTo: category).snapshots();
  }

  static getProductsbysubcat(subcategory){
    return firestore.collection(productsCollection).where('p_subcat',isEqualTo: subcategory).snapshots();

  }
  
  // get cart

  static getCart(uid){
    return firestore.collection(cartCollection).where('added_by',isEqualTo: uid).snapshots();
  }

  static deleteDocument(dicId){
    return firestore.collection(cartCollection).doc(dicId).delete();

  }

  static getOrders(){
    return firestore.collection(ordersCollection).where('order_by',isEqualTo:currentuser!.uid).snapshots();

  }
  
  static wishlist(){
    return firestore.collection(productsCollection).where('p_wishlist', arrayContains: currentuser!.uid).snapshots();
  }

  static getorderlist(){
    return firestore.collection(ordersCollection).where('order_by',isEqualTo: currentuser!.uid).snapshots();
  }

  static getorderID(){
    return firestore.collection(ordersCollection).where('order_code',isEqualTo: currentuser!.uid).snapshots();

  }
  static getoderdetail(){
    return firestore.collection(ordersCollection).where('order_confirm',isEqualTo: currentuser!.uid).snapshots();

  }


  static shippingMethod(){
    return firestore.collection(ordersCollection).where('shipping method',isEqualTo: currentuser!.uid).snapshots();

  }
  static getCount() async{
    var res= await Future.wait([
      firestore.collection(cartCollection).where('added_by',isEqualTo: currentuser!.uid).get().then((value) => value.docs.length),

      firestore.collection(productsCollection).where('p_wishlist', isEqualTo: currentuser!.uid).get().then((value) => value.docs.length),
      firestore.collection(ordersCollection).where('order_by',isEqualTo: currentuser!.uid).get().then((value) => value.docs.length),
    ]);

  }



}