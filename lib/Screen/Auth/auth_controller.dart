import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rest_api_task/Screen/Auth/login_screen.dart';
import 'package:rest_api_task/Screen/HomeScreen/home_screen.dart';
import 'package:rest_api_task/Services/api_service.dart';

class AuthController extends GetxController {

// loading 
var isSignupLoading=false.obs;
var isLoginLoading=false.obs;


// device info
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> deviceData = <String, dynamic>{};

  final loginEmailTextCtrl = TextEditingController();
  final loginPassTextCtrl = TextEditingController();

  final userNameTextCtrl = TextEditingController();
  final emailTextCtrl = TextEditingController();
  final passTextCtrl = TextEditingController();
  final conPassTextCtrl = TextEditingController();

  // all token
  String fcmToken = "";
  String? responseToken;

  @override
  void onInit() {
    allRequest();
    super.onInit();
  }

  allRequest()async{
    await getToken();
    await initPlatformState();
    await bindDevice();
  }



  getToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      fcmToken = value!;
      

    });
  }

  Future<void> initPlatformState() async {
    var getdeviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        getdeviceData =
            _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      }
    } on PlatformException {
      getdeviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    deviceData = getdeviceData;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
          ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
      'serialNumber': build.serialNumber,
    };
  }

  bindDevice() async {
    try {
      var result = await ApiService.postBindDevice(
          source: "com.example.rest_api_task",
          token: fcmToken,
          optionals: deviceData);
      if (result.runtimeType == int) {
        if (kDebugMode) {
          print("Bind device error.");
        }
      } else {
        responseToken = result;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print("Bind device error :$e");
      }
    }
  }

 handleSingup() async {
    try {
      isSignupLoading(true);
      Map<String,dynamic> body={
          "name":userNameTextCtrl.text,
          "email":emailTextCtrl.text,
          "password":passTextCtrl.text,
          "confirmPassword":conPassTextCtrl.text
      };

      var result = await ApiService.signUp(body:body , devNoteInfo: responseToken!);
      if (result.runtimeType==int) {
        if (kDebugMode) {
          print("User singup error.");
        }
      } else {
        Get.snackbar("Success",result["message"]);
        Get.off(LoginScreen());
        userNameTextCtrl.clear();
        emailTextCtrl.clear();
        passTextCtrl.clear();
        conPassTextCtrl.clear();
         isSignupLoading(false);
      }
    } on Exception catch (e) {
       isSignupLoading(false);
      if (kDebugMode) {
        print("Signup  error :$e");
      }
    }finally{
       isSignupLoading(false);
    }
  }

handleLogin() async {
    try {
      isLoginLoading(true);
      Map<String,dynamic> body={
          
          "email":loginEmailTextCtrl.text,
          "password":loginPassTextCtrl.text,
          
      };

      var result = await ApiService.login(body:body , devNoteInfo: responseToken!);
      if (result.runtimeType==int) {
        if (kDebugMode) {
          print("User login error.");
        }
      } else {
        Get.snackbar("Success",result["message"]);
        Get.off(HomeScreen());
        loginEmailTextCtrl.clear();
        loginPassTextCtrl.clear();
         isLoginLoading(false);
      }
    } on Exception catch (e) {
       isLoginLoading(false);
      if (kDebugMode) {
        print("Login  error :$e");
      }
    }finally{
       isLoginLoading(false);
    }
  }


}
