import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator(){
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(Colors.orangeAccent),
  );
}