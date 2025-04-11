import 'package:bluxkart/constants/consts.dart';
import 'package:bluxkart/controllers/home_controller.dart';
import 'package:bluxkart/views/Cart_screen/cart_screen.dart';
import 'package:bluxkart/views/Category_screen/category_screen.dart';
import 'package:bluxkart/views/home_screen/home_screen.dart';
import 'package:bluxkart/views/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Home extends StatelessWidget{
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(icon: Image.asset(icHome , width: 26,), label:home ),
      BottomNavigationBarItem(icon: Image.asset(icCategories , width: 26,), label:categories )
      ,BottomNavigationBarItem(icon: Image.asset(icCart , width: 26,), label:cart ),
      BottomNavigationBarItem(icon: Image.asset(icProfile , width: 26,), label:account )
    ];

    var navBody = [
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen()
    ];


    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body:Column(
          children: [
            Obx(() => Expanded(child: navBody.elementAt(controller.currentNavIndex.value))),
          ],
        ),
          bottomNavigationBar: Obx( ()=>
              BottomNavigationBar(items: navbarItem,
                currentIndex: controller.currentNavIndex.value,
                onTap: (index){
                  controller.currentNavIndex.value = index;
                },
                backgroundColor: Colors.white,
                type:BottomNavigationBarType.fixed ,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),

            ),
          ),
      ),
    );

  }

}