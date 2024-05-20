import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_project/services/auth_services/auth.dart';
import 'package:music_app_project/views/components/components.dart';
import 'package:music_app_project/views/screens/auth_screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPass = false;
  bool checkTheBox = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void showPassword() {
    setState(() {
      showPass = !showPass;
    });
  }

  void check() {
    setState(() {
      checkTheBox = !checkTheBox;
    });
  }

  @override
  void initState() {
    Auth.checkLogout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.deepPurple.shade800,
            Colors.deepPurple.shade200,
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Image.asset(
                  'assets/images/radio_wave_beta.png',
                  color: Colors.deepPurple.shade200.withOpacity(0.5),
                  width: 300,
                ),
                const SizedBox(height: 80),
                _buildFormLogin(),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Không có tài khoản?',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(() => const SignupScreen());
                      },
                      child: Text(
                        'Đăng ký!',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form _buildFormLogin() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextField(
            hintText: 'Tên tài khoản hoặc email',
            controller: emailController,
            validator: (text) =>
                text!.isEmpty ? 'Trường này không được bỏ trống' : null,
          ),
          const SizedBox(height: 20),
          AppTextField(
            hintText: 'Mật khẩu',
            onPressed: showPassword,
            obscureText: showPass ? false : true,
            icon: showPass ? Icons.visibility_off : Icons.visibility,
            controller: passwordController,
            validator: (text) =>
                text!.isEmpty ? 'Trường này không được bỏ trống' : null,
          ),
          const SizedBox(height: 12),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: const SectionHeader(title: '', action: 'Quên mật khẩu?'),
          ),
          const SizedBox(height: 20),
          AppButton(
            color: Colors.deepPurple.withOpacity(0.75),
            text: 'Đăng nhập',
            onTap: () {
              if (_formKey.currentState!.validate()) {
                Auth.login(
                  emailController.text.toString(),
                  passwordController.text.toString(),
                  (bool success, dynamic responseData) {
                    if (!success) {
                      Get.dialog(
                        AppAlertDialog(
                          content:
                              utf8.decode(responseData['message'].codeUnits),
                          onPressed: () => Get.back(),
                        ),
                      );
                    }
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
