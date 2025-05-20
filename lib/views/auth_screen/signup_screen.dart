import 'package:bluxkart/constants/consts.dart';
import 'package:bluxkart/constants/lists.dart';
import 'package:bluxkart/controllers/auth_controller.dart';
import 'package:bluxkart/views/Wigets_common/bg_Widget.dart';
import 'package:bluxkart/views/Wigets_common/custom_Textfield.dart';
import 'package:bluxkart/views/Wigets_common/our_button.dart';
import 'package:bluxkart/views/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';


class SignupScreen extends StatefulWidget{
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool? isCheck = false;
  var controller = Get.put(authController());
  var isPasswordVisible = false.obs;



  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child:Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (context.screenHeight * 0.1 ).heightBox,
                  SizedBox(
                      height: 150,
                      child: Image.asset("assets/Logo/Main_logo-removebg-preview.png",).scale200()),

                  // Text("Log in to Bluxkart ", style: TextStyle(fontSize: 20, color: Colors.purple , fontWeight: FontWeight.bold ),),
                  15.heightBox,


                  Obx(()=>
                     Column(
                        children: [
                          customTextField(hint: nameHint, title: name, controller: nameController,isPass: false),
                          10.heightBox,
                          customTextField(hint: emailHint, title: email, controller: emailController,isPass: false),
                          10.heightBox,
                          customTextField(hint: passwordHint, title: password, controller: passwordController,isPass: true),
                          10.heightBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Retype Password",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: passwordRetypeController,
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
                          ),

                          10.heightBox,
                          Row(
                              children: [
                                Checkbox
                                  (checkColor: Colors.white,
                                    activeColor: Colors.orangeAccent
                                    ,value: isCheck, onChanged: (newValue){
                                      setState(() {
                                        isCheck = newValue;

                                      });
                                    }),
                                10.widthBox,
                                Expanded(
                                  child: RichText(
                                      text: const TextSpan(
                                          children: [
                                            TextSpan(
                                                text: "I agree to the ",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                )),TextSpan(
                                                text: termsAndConditions,
                                                style: TextStyle(
                                                  color: Colors.orangeAccent,
                                                  fontWeight: FontWeight.bold,
                                                )),TextSpan(
                                                text: "& ",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                )),TextSpan(
                                                text: privacyPolicy,
                                                style: TextStyle(
                                                  color: Colors.orangeAccent,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ]
                                      )

                                  ),
                                )
                              ]
                          ),
                          5.heightBox,
                          controller.isloading.value ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.orangeAccent),
                          ):
                          ourButton(title: signup, color: isCheck == true ? Colors.orangeAccent : Colors.grey, texTcolor: Colors.black,  onPress: () async {
                            if(isCheck != false){
                              controller.isloading(true);

                              try{
                                await controller.signupMethod(
                                  name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context
                                ).then((value) {
                                  return controller.storeUserData(
                                      name: nameController.text,
                                      email: emailController.text,


                                  );
                                }

                            ).then((value){
                              VxToast.show(context, msg: "Account created successfully");
                              Get.off(() =>Home());
                                }
                                );
                              }
                              catch(e){
                                auth.signOut();
                                VxToast.show(context, msg: "Fill all the fields");
                                controller.isloading(false);
                              }
                            }

                          })
                              .box
                              .width(context.screenWidth - 50)
                              .make(),
                          10.heightBox,
                          RichText(text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: "Already have an account? ",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    )),TextSpan(
                                    text: login,
                                    style: TextStyle(
                                      color: Colors.orangeAccent,
                                    )
                                )
                              ]
                          )).onTap(() {
                            Get.back();
                          }),




                        ]

                    ).box.color(Colors.white).rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
                  )


                ],
              ),
            )
        ),
      ),
    );
  }
}