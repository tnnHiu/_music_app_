import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:music_app_project/constants/app_constants.dart';
import 'package:music_app_project/views/screens/auth_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

typedef LoginCallback = void Function(bool success);
typedef RegisterCallback = void Function(bool success);

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
      debugPrint(token);
      Get.offAll(() => const AppMainScreen());
    } else {
      debugPrint('No token');
      callback(false);
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
      callback(true);
    } else {
      callback(false);
    }
  }

  static void logout() async {
    var url = Uri.parse('${apiUrl}logout');
    String? token = await readCache(key: 'token');
    if (token != null) {
      Map<String, String>? headers = {'token': token};
      var response = await http.post(url, headers: headers);
      var responseData = jsonDecode(response.body);
      if (responseData['success'] == true) {
        removeCache();
        Get.offAll(() => const LoginScreen());
      }
    }
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
      debugPrint(value);
      return value;
    }
    debugPrint('Khong co token');
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
