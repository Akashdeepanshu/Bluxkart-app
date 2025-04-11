import 'package:bluxkart/constants/consts.dart';
import 'package:bluxkart/controllers/auth_controller.dart';
import 'package:bluxkart/controllers/profileController.dart';
import 'package:bluxkart/sevices/firestore_services.dart';
import 'package:bluxkart/views/Cart_screen/cart_screen.dart';
import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:bluxkart/views/auth_screen/Login_screen.dart';
import 'package:bluxkart/views/order_screens/order_screen.dart';
import 'package:bluxkart/views/order_screens/wishlist_screen.dart';
import 'package:bluxkart/views/profile_screen/components/detail_card.dart';
import 'package:bluxkart/views/profile_screen/editProfile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Aboutus_screen.dart';
import 'Contact_Screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileController());
    final controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentuser!.uid),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.orangeAccent),
                ),
              );
            } else {
              var data = snapshot.data.docs[0];
              FirestoreServices.updateUserCount(currentuser!.uid);

              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Profile Header
                      Card(
                        color: Colors.white.withOpacity(0.05),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.orangeAccent,
                                child: Text(
                                  data['name'].toString()[0].toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                              ),
                              16.widthBox,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    data['name']
                                        .toString()
                                        .text
                                        .white
                                        .xl
                                        .bold
                                        .make(),
                                    data['email'].toString().text.white.make(),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.logout,
                                    color: Colors.white),
                                onPressed: () async {
                                  await Get.put(authController())
                                      .signoutMethod(context);
                                  Get.delete<ProfileController>();
                                  VxToast.show(context,
                                      msg: "Logout Successfully");
                                  Get.offAll(() => LoginScreen());
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      20.heightBox,

                      /// Edit Profile Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            controller.namecontroller.text = data['name'];
                            controller.oldPasswordController.clear();
                            controller.newPasswordController.clear();
                            controller.confirmnewPasswordController.clear();
                            Get.to(() => EditprofileScreen(data: data));
                          },
                          icon: const Icon(Icons.edit, color: Colors.white),
                          label: "Edit Profile".text.white.make(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),

                      20.heightBox,

                      /// Details Row (Orders, Wishlist, Cart)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () => Get.to(() => orderScreen()),
                              child: detailsCard(
                                count: data["order_count"].toString(),
                                title: "Orders",
                                width: context.screenWidth / 3.4,
                              ),
                            ),
                            InkWell(
                              onTap: () => Get.to(() => wishlistScreen()),
                              child: detailsCard(
                                count: data["wishlist_count"].toString(),
                                title: "Wishlist",
                                width: context.screenWidth / 3.4,
                              ),
                            ),
                            InkWell(
                              onTap: () => Get.to(() => CartScreen()),
                              child: detailsCard(
                                count: data["cart_count"].toString(),
                                title: "Cart",
                                width: context.screenWidth / 3.4,
                              ),
                            ),
                          ],
                        ),
                      ),

                      30.heightBox,

                      /// Profile Options List
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: profilebuttonList.length,
                        separatorBuilder: (context, index) =>
                            Divider(color: Colors.white24),
                        itemBuilder: (context, index) {
                          return ListTile(
                            tileColor: Colors.white.withOpacity(0.03),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            leading: Image.asset(
                              profilebuttonIcon[index],
                              height: 24,
                              width: 24,
                              color: Colors.orangeAccent,
                            ),
                            title: profilebuttonList[index].text.white.make(),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Colors.white, size: 16),
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(() => const wishlistScreen());
                                  break;
                                case 1:
                                  Get.to(() => const orderScreen());
                                  break;
                                case 2:
                                  Get.to(() => ContactScreen());
                                  break;
                                case 3:
                                  Get.to(() => AboutusScreen());
                                  break;
                              }
                            },
                          );
                        },
                      )
                          .box
                          .border(color: Colors.white10)
                          .roundedSM
                          .padding(const EdgeInsets.all(12))
                          .make(),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
