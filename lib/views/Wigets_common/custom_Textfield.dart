import 'package:bluxkart/constants/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customTextField({String? title, String? hint , controller,isPass}){
  return Column(

    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      title!.text.color(Colors.black).size(16).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white54),
          isDense: true,
          fillColor: Colors.grey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),

        ),
      )




    ],
  );
}