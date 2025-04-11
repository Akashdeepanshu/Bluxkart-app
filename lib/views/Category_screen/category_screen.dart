import 'package:bluxkart/constants/consts.dart';
import 'package:bluxkart/constants/lists.dart';
import 'package:bluxkart/views/Category_screen/categories_detail.dart';
import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
class CategoryScreen extends StatelessWidget{
  const CategoryScreen ({super.key});


  @override
  Widget build(BuildContext context) {



    return
      Scaffold(
          body:  Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8E2DE2), Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    height: 200,
                    //color: Colors.black,
                    child: Image.asset("assets/Logo/Main_logo-removebg-preview.png",),
                  ),
                  Text("Categories",style: TextStyle(fontSize: 50,color: Colors.white,fontWeight: FontWeight.bold,),),
                  GridView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 5,mainAxisSpacing: 5), itemBuilder: (context, index){
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20), // Rounded border
                          child: Image.asset(
                            categoryList[index],
                            height: 200,
                            width: 200,

                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.7),
                        ),),

                        10.heightBox,
                        Align(
                            alignment: Alignment.center
                            ,child: Text(categorynames[index],style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),))

                      ],
                    ).box.roundedSM.clip(Clip.antiAlias).outerShadowSm.padding(EdgeInsets.all(8)).make().onTap(() {
                      Get.to(() => CategoryDetail(title: categorynames[index],),transition: Transition.rightToLeftWithFade);
                    });
                  })


                ]
              )

          )
      );
  }

}

