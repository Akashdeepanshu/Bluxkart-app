

import 'package:bluxkart/constants/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

Widget detailsCard({width, String? count, String? title}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.bold.black.size(16).make(),
      5.heightBox,
      title!.text.black.make(),

    ],
  ).box.padding(EdgeInsets.all(12)).white.roundedSM.width(width).padding(const EdgeInsets.all(8)).height(80).make();

}