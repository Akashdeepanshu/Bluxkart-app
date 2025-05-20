import 'package:bluxkart/constants/consts.dart';
import 'package:bluxkart/constants/lists.dart';
import 'package:bluxkart/controllers/auth_controller.dart';
import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:bluxkart/views/Wigets_common/custom_Textfield.dart';
import 'package:bluxkart/views/Wigets_common/our_button.dart';
import 'package:bluxkart/views/auth_screen/signup_screen.dart';
import 'package:bluxkart/views/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:velocity_x/velocity_x.dart';

import 'foregetPassword_screen.dart';


class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(authController());
    var isPasswordVisible = false.obs;




    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
           child:Column(
             mainAxisSize: MainAxisSize.min,
             children: [

               (context.screenHeight * 0.1 ).heightBox,

               SizedBox(
                   height: 150,
                   child: Image.asset("assets/Logo/Main_logo-removebg-preview.png",).scale200()),

               // Text("Log in to Bluxkart ", style: TextStyle(fontSize: 20, color: Colors.purple , fontWeight: FontWeight.bold ),),
               15.heightBox,


               Center(
                 child: Obx(()=>
                   Column(
                       children: [

                         customTextField(hint: emailHint, title: email,isPass: false,controller: controller.emailController),
                         10.heightBox,
                         Obx(() {
                           return Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(password, style: TextStyle(fontWeight: FontWeight.bold)),
                               5.heightBox,
                               TextFormField(
                                 controller: controller.passwordController,
                                 obscureText: !isPasswordVisible.value,
                                 decoration: InputDecoration(
                                   labelText: "*******",
                                   labelStyle: const TextStyle(color: Colors.white),
                                   enabledBorder: OutlineInputBorder(
                                     borderSide: const BorderSide(color: Colors.grey),
                                     borderRadius: BorderRadius.circular(12),
                                   ),
                                   focusedBorder: OutlineInputBorder(
                                     borderSide: const BorderSide(color: Colors.grey),
                                     borderRadius: BorderRadius.circular(12),
                                   ),
                                   fillColor: Colors.grey,
                                   filled: true,
                                   border: OutlineInputBorder(),
                                   suffixIcon: IconButton(
                                     icon: Icon(
                                       isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                                       color: Colors.white,
                                     ),

                                     onPressed: () {
                                       isPasswordVisible.toggle();
                                     },
                                   ),
                                 ),
                               ),
                             ],
                           );
                         }),

                         5.heightBox,
                         controller.isloading.value ? CircularProgressIndicator(
                           valueColor: AlwaysStoppedAnimation(Colors.orangeAccent),
                         ):  ourButton(title: login, onPress: () async {
                           controller.isloading(true);
                           await controller.loginMethod(context: context).then((value) {
                             if (value != null){
                               VxToast.show(context, msg: "Login Successfully");
                               Get.offAll(()=> Home());
                             }else{
                               controller.isloading(false);
                             }

                           });
                         }, color: Colors.orangeAccent, texTcolor: Colors.black)
                             .box
                             .width(context.screenWidth - 50)
                             .make(),
                         Align(
                             alignment:Alignment.centerRight ,
                             child: TextButton(onPressed: ( ){
                               Get.to(() => ForgotPasswordScreen());
                             }, child: forgetPassword.text.make())),

                         10.heightBox,
                         createNewAccount.text.color(Colors.grey).make(),
                         5.heightBox,
                         ourButton(title: signup , onPress: (){
                           Get.to(() => const SignupScreen());

                         }, color: Colors.orangeAccent, texTcolor: Colors.black)
                             .box
                             .width(context.screenWidth - 50)
                             .make(),
                         10.heightBox,





                       ]

                   ).box.color(Colors.white).rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
                 ),
               )


             ],
           )
                  ),
      ),
    );
  }
}