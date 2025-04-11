import 'package:bluxkart/constants/consts.dart';
import 'package:bluxkart/controllers/profileController.dart';
import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditprofileScreen extends StatelessWidget {
  final dynamic data;

  const EditprofileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    if (controller.namecontroller.text.isEmpty && data != null) {
      controller.namecontroller.text = data['name'] ?? '';
    }

    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Edit Profile",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Obx(
              () => SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),


                  TextField(
                    controller: controller.namecontroller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: nameHint,
                      hintStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white70),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.orangeAccent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),


                  TextField(
                    controller: controller.oldPasswordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Current Password",
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: "Enter current password",
                      hintStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white70),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.orangeAccent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),


                  TextField(
                    controller: controller.newPasswordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "New Password",
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: "Enter new password",
                      hintStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white70),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.orangeAccent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),


                  TextField(
                    controller: controller.confirmnewPasswordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Confirm New Password",
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: "Re-enter new password",
                      hintStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white70),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.orangeAccent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),


                  controller.isloading.value
                      ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.orangeAccent),
                  )
                      : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        final name = controller.namecontroller.text.trim();
                        final oldPass =
                        controller.oldPasswordController.text.trim();
                        final newPass =
                        controller.newPasswordController.text.trim();
                        final confirmPass = controller
                            .confirmnewPasswordController.text
                            .trim();

                        if (name.isEmpty) {
                          VxToast.show(context,
                              msg: "Name cannot be empty");
                          return;
                        }

                        if (newPass != confirmPass) {
                          VxToast.show(context,
                              msg: "New passwords do not match");
                          return;
                        }

                        controller.isloading.value = true;

                        await controller.updateProfile(
                          name: name,
                          oldPassword: oldPass,
                          newPassword: newPass,
                          context: context,
                        );

                        controller.isloading.value = false;
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
