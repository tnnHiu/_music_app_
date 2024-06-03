import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_project/services/auth_services/auth.dart';
import 'package:music_app_project/views/screens/auth_screen/login_screen.dart';

import '../../components/app_alert_dialog.dart';
import '../../components/app_button.dart';
import '../../components/app_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool showPass = false;
  bool checkTheBox = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // dynamic _validateConfirmPassword(String password, String confirmPassword) {
  //   if (password == confirmPassword) {
  //     return 'Xác nhận khẩu không trùng khớp';
  //   }
  //   return null;
  // }

  showPassword() {
    setState(() {
      showPass = !showPass;
    });
  }

  check() {
    setState(() {
      checkTheBox = !checkTheBox;
    });
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
                const SizedBox(height: 60),
                _buildFormRegister(context),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Đã có tài khoản?',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(() => const LoginScreen());
                      },
                      child: Text(
                        'Đăng nhập!',
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

  Form _buildFormRegister(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextField(
            hintText: 'Tên đầy đủ',
            controller: fullNameController,
            validator: (text) =>
                text!.isEmpty ? 'Trường này không được bỏ trống' : null,
          ),
          const SizedBox(height: 20),
          AppTextField(
            hintText: 'Số điện thoại',
            isTypeNumber: true,
            controller: phoneNumController,
            validator: (text) =>
                text!.isEmpty ? 'Trường này không được bỏ trống' : null,
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          AppTextField(
              hintText: 'Xác nhận mật khẩu',
              onPressed: showPassword,
              obscureText: showPass ? false : true,
              icon: showPass ? Icons.visibility_off : Icons.visibility,
              controller: confirmPasswordController,
              validator: (confirmPassword) {
                if (confirmPassword!.isEmpty) {
                  return 'Trường này không được bỏ trống';
                }
                if (confirmPassword != passwordController.text.toString()) {
                  return 'Xác nhận mật khẩu không đúng';
                }
                return null;
              }),
          const SizedBox(height: 20),
          AppButton(
            color: Colors.deepPurple.withOpacity(0.75),
            text: 'Đăng ký',
            onTap: () {
              if (_formKey.currentState!.validate()) {
                Auth.register(
                  fullNameController.text.toString(),
                  phoneNumController.text.toString(),
                  emailController.text.toString(),
                  passwordController.text.toString(),
                  (bool success) {
                    if (success) {
                      Get.dialog(
                        AppAlertDialog(
                          content: 'Đăng ký thành công',
                          onPressed: () => Get.offAll(const LoginScreen()),
                        ),
                      );
                    } else {
                      Get.dialog(
                        AppAlertDialog(
                            content: 'Đăng ký thất bại, vui lòng thử lại',
                            onPressed: () => Get.back()),
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
