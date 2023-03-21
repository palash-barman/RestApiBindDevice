import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'api_components.dart';

class ApiService {
  static var client = http.Client();

  static Future<dynamic> postBindDevice(
      {required String source,
      required String token,
      required Map<String, dynamic> optionals}) async {
    try {
      var headers = {
        'source': 'com.palash.barman',
        'Content-Type': 'application/json'
      };
      var body = json
          .encode({"source": source, "token": token, "optionals": optionals});
      var response = await client.post(Uri.parse(bindDeviceApi),
          body: body, headers: headers);
      if (response.statusCode == 200) {
        Map d = json.decode(response.body);
          print("data : $d");
        return d["data"]["device"]["dhKey"];
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        return 1;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print("Bind device error. Reason ${e.toString()}");
      }
      return 1;
    }
  }

  static Future<dynamic> signUp(
      {required Map<String, dynamic> body, required String devNoteInfo}) async {
    try {
      var headers = {
        'source': 'com.palash.barman',
        'device':devNoteInfo,
        'Content-Type': 'application/json'
      };

      var response = await client.post(Uri.parse(signupApi),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        Map d = jsonDecode(response.body);
       
        Fluttertoast.showToast(msg: d["message"],);
        return response.statusCode;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print("Signup error. Reason ${e.toString()}");
      }
      return 1;
    }
  }

   static Future<dynamic> login(
      {required Map<String, dynamic> body, required String devNoteInfo}) async {
    try {
      var headers = {
        'source':'com.palash.barman',
        'device': devNoteInfo,
        'Content-Type': 'application/json'
      };

      var response = await client.post(Uri.parse(loginApi),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        Map d = jsonDecode(response.body);
        
        Fluttertoast.showToast(msg: d["message"],);
        return response.statusCode;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print("Login error. Reason ${e.toString()}");
      }
      return 1;
    }
  }
}
