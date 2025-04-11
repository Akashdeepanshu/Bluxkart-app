import 'dart:ui';
import 'package:bluxkart/views/splash_screen/splash_screen_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bluxkart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        splashColor: Colors.transparent,
         appBarTheme: const AppBarTheme(
           actionsIconTheme: IconThemeData(color: Colors.white),
           backgroundColor: Colors.transparent

        ),
       ),
      home: SplashScreen(),


    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {




  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body:Container(


          color: Theme.of(context).colorScheme.inversePrimary,
          child: Center(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white,width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: Offset(0, 3), // changes position of shadow
                    )],

                ),
                height: 400,
                width: 300,
                //color: Colors.blue,





                )
            ),
          ),


    );
  }
}

