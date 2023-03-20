

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rest_api_task/Screen/Auth/auth_controller.dart';
import 'package:rest_api_task/Screen/Auth/signup_screen.dart';

import '../../Utilities/outline_border.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

final _authController=Get.put(AuthController());


 final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Obx(()=>
            _authController.isLoginLoading.value? const Center(child:CircularProgressIndicator(),): SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 17.w,vertical: 18.h
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: [
                    SizedBox(height: 135.h,),
                      Text("Login",style: TextStyle(color:const Color.fromARGB(255, 106, 132, 204),fontWeight: FontWeight.bold,fontSize:35.sp),)
             ,  SizedBox(height: 120.h,),
                      TextFormField(
                        controller: _authController.loginEmailTextCtrl,
                        decoration: InputDecoration(
                          hintText: "Email",
                          
                          border: outlineBorder()
                        ),
                        validator: (value){
          
                            if(value!.isEmpty){
                              return "Please enter your email.";
                            }
          
                          return null;
                        },
                      )
                    ,
                     SizedBox(height: 15.h,),
                    TextFormField(
                      controller: _authController.loginPassTextCtrl,
                      obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          
                          border:  outlineBorder()
                        ),
                          validator: (value){
          
                            if(value!.isEmpty){
                              return "Please enter your password.";
                            }
          
                          return null;
                        },
                      ),
                      SizedBox(height: 15.h,),
                      Row(
                        
                        children: const [
                        Spacer(),
                        Text("Forget Password",style: TextStyle(color: Colors.black),),
                      ],),
                  
              SizedBox(height: 105.h,),
                  
              ElevatedButton(onPressed: (){
                
                  if(formkey.currentState!.validate()){
                      _authController.handleLogin();
                  }
          
          
              }, child: Text("Login"),style: ElevatedButton.styleFrom(fixedSize: Size(200.w
              , 50.h)),),
                  SizedBox(height: 45.h,),
                  
                  RichText(text:TextSpan(
            text: "Don't have an account ? ",
            style: TextStyle(fontSize:14.sp,color:Colors.black54),
            children: [
              TextSpan(
                text: "Signup",
                recognizer:TapGestureRecognizer()..onTap = () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=>SignupScreen()));
                },
                style: TextStyle(fontSize:16.sp,color:Colors.black,fontWeight: FontWeight.w500),
              )
            ]
                  ))
                  
                  
                  
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}