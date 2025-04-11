import 'package:bluxkart/constants/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class authController extends GetxController {

  var isloading = false.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();



  UserCredential? userCredential;

  Future<UserCredential?> loginMethod({email, password, context}) async {
    try {
      userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );


      currentuser = auth.currentUser;

      return userCredential;
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return null;
  }
  Future<void> resetPasswordMethod({required BuildContext context}) async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      VxToast.show(context, msg: "Please enter your email");
      return;
    }

    try {
      await auth.sendPasswordResetEmail(email: email);
      VxToast.show(context, msg: "Password reset email sent!");
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? "Error sending reset email");
    }
  }


  Future<UserCredential?> signupMethod({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );


      currentuser = auth.currentUser;

      await storeUserData(
        name: name,
        email: email,
        context: context,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        VxToast.show(context, msg: e.toString());
      }
    }
    return null;
  }



  storeUserData({name, email, context}) async {
    if (currentuser == null) {
      await Future.delayed(Duration(seconds: 2));
      currentuser = auth.currentUser;
    }

    if (currentuser != null) {
      DocumentReference store = firestore.collection(usersCollection).doc(currentuser!.uid);
      store.set({
        'name': name,
        'email': email,
        'imageUrl': '',
        'id': currentuser!.uid,
        'cart_count': '00',
        'order_count': '00',
        'wishlist_count': '00',
      });
    } else {
      VxToast.show(context, msg: "Error: User not found.");
    }
  }


  signoutMethod(context) async {
    try {
      await auth.signOut();
      currentuser = null;
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }




}
