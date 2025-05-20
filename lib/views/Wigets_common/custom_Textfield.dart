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
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white54),
          isDense: true,
          fillColor: Colors.grey,
          filled: true,
          border: InputBorder.none,


        ),
      )




    ],
  );
}