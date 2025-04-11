import 'package:bluxkart/constants/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;


class ProfileController extends GetxController {


  var isloading = false.obs;

  var namecontroller = TextEditingController();
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmnewPasswordController = TextEditingController();

  Future<void> updateProfile({
    required String name,
    required String oldPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      isloading.value = true;

      // Update name in Firestore
      await firestore.collection(usersCollection).doc(currentuser!.uid).set({
        'name': name,
      }, SetOptions(merge: true));

      // Re-authenticate and change password only if user entered it
      if (oldPassword.isNotEmpty && newPassword.isNotEmpty) {
        final email = currentuser!.email!;
        final cred = EmailAuthProvider.credential(email: email, password: oldPassword);

        await currentuser!.reauthenticateWithCredential(cred);
        await currentuser!.updatePassword(newPassword);
      }

      VxToast.show(context, msg: "Profile updated successfully");
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? "Something went wrong");
    } finally {
      isloading.value = false;
    }
  }




  //
  // changeImage(context)async {
  //   try {
  //     final img = await ImagePicker().pickImage(
  //         source: ImageSource.gallery, imageQuality: 70);
  //
  //     if (img == null) return;
  //     profileImgPath.value = img.path;
  //   }
  //   on PlatformException  catch (e) {
  //     VxToast.show(context, msg: e.toString());
  //
  //   }
  // }


}