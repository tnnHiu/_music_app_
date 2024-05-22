import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:music_app_project/constants/app_constants.dart';
import 'package:music_app_project/views/screens/auth_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

typedef LoginCallback = void Function(bool success, dynamic responseData);
typedef RegisterCallback = void Function(bool success, dynamic responseData);

class Auth {
  static late SharedPreferences preferences;

  static Future<void> checkLogout() async {
    String? token = await readCache(key: 'token');
    debugPrint(token);
    if (token != null) {
      Get.offAll(() => const AppMainScreen());
    }
  }

  static void login(
    String email,
    String password,
    LoginCallback callback,
  ) async {
    var url = Uri.parse('${apiUrl}login');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'email': email, 'password': password});
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    var responseData = jsonDecode(response.body);
    if (responseData['success'] == true) {
      var token = responseData['token'];
      writeCache(key: 'token', value: token);
      Get.offAll(() => const AppMainScreen());
    } else {
      callback(false, responseData);
    }
  }

  static void register(
    String fullName,
    String phoneNum,
    String email,
    String password,
    RegisterCallback callback,
  ) async {
    var url = Uri.parse('${apiUrl}register');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      "email": email,
      "password": password,
      "fullName": fullName,
      "phoneNumber": phoneNum,
      "status": true
    });
    var response = await http.post(url, headers: headers, body: body);
    var responseData = jsonDecode(response.body);
    if (responseData['success'] == true) {
      callback(true, responseData);
    } else {
      callback(false, responseData);
    }
  }

  static void logout() async {
    // var url = Uri.parse('${apiUrl}logout');
    // var token = await readCache(key: 'token');
    // if (token != null) {
    //   Map<String, String>? headers = {'token': token};
    //   var response = await http.post(url, headers: headers);
    //   var responseData = jsonDecode(response.body);
    //   if (responseData['success'] == true) {
    removeCache();
    Get.offAll(() => const LoginScreen());
    // }
    // }
  }

  static Future<void> writeCache(
      {required String key, required String value}) async {
    preferences = await SharedPreferences.getInstance();
    await preferences.setString('token', value);
  }

  static Future<String?> readCache({required String key}) async {
    preferences = await SharedPreferences.getInstance();
    String? value = preferences.getString(key);
    if (value != null) {
      return value;
    }
    return null;
  }

  static Future<void> removeCache() async {
    bool isRemoved = await preferences.clear();
    if (isRemoved) {
      debugPrint('removed');
      Get.off(() => const LoginScreen());
    }
  }
}
