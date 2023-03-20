import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      
      body: Column(
        children: [
          Center(
            child: Text("Welcome",style: TextStyle(fontWeight: FontWeight.w600,fontSize:25.sp,color: Colors.black),),
          )
        ],
      ),
    );
  }
}