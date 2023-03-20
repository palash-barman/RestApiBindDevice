import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rest_api_task/Screen/Auth/auth_controller.dart';
import 'package:rest_api_task/Screen/Auth/login_screen.dart';

import '../../Utilities/outline_border.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});

   final formkey = GlobalKey<FormState>();

   final _authController=Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
            key:formkey ,
            child: Obx(()=>_authController.isSignupLoading.value? const Center(child:CircularProgressIndicator(),):
               SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 18.h),
                    child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 100.h,
                  ),
                  Text(
                    "Signup",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 106, 132, 204),
                        fontWeight: FontWeight.bold,
                        fontSize: 35.sp),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  TextFormField(
                    controller: _authController.userNameTextCtrl,
                    decoration:
                        InputDecoration(hintText: "User name", border: outlineBorder()),
                          validator: (value){
            
                            if(value!.isEmpty){
                              return "Please enter your user name.";
                            }
            
                          return null;
                        },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFormField(
                    controller: _authController.emailTextCtrl,
                    decoration:
                        InputDecoration(hintText: "Email", border: outlineBorder()),
                          validator: (value){
            
                            if(value!.isEmpty){
                              return "Please enter your email.";
                            }
            
                          return null;
                        },
                        
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFormField(
                    controller: _authController.passTextCtrl,
                    decoration: InputDecoration(
                        hintText: "Password", border: outlineBorder()),
                          validator: (value){
            
                            if(value!.isEmpty){
                              return "Please enter your password.";
                            }
            
                          return null;
                        },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFormField(
                    controller: _authController.conPassTextCtrl,
                    decoration: InputDecoration(
                        hintText: "Confirm Password", border: outlineBorder()),
                          validator: (value){
            
                            if(value!.isEmpty){
                              return "Please enter confirm password.";
                            }else if(value!=_authController.passTextCtrl.text){
                              return "Password does not match";
                            }
            
                          return null;
                        },
                  ),
                  SizedBox(
                    height: 90.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
            
                      if(formkey.currentState!.validate()){
                        _authController.handleSingup();
                      }
                    },
                    style: ElevatedButton.styleFrom(fixedSize: Size(200.w, 50.h)),
                    child: const Text("Signup"),
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Already have an account ? ",
                          style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                          children: [
                        TextSpan(
                          text: "Login",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => LoginScreen()));
                            },
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        )
                      ]))
                ],
              ),
                    ),
                  ),
            ),
          )),
    );
  }
}
