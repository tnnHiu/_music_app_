import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_project/views/components/app_button.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200..withOpacity(0.8),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 140),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Image.asset(
                        'assets/images/radio_wave_beta.png',
                        color: Colors.deepPurple.shade200.withOpacity(0.5),
                      ),
                    ),
                    AppButton(
                      color: Colors.deepPurple.withOpacity(0.35),
                      text: 'Đăng nhập',
                      onTap: () {
                        Get.toNamed('/login');
                      },
                    ),
                    const SizedBox(height: 20),
                    AppButton(
                      color: Colors.deepPurple.withOpacity(0.75),
                      text: 'Tạo tài khoản mới',
                      onTap: () {
                        Get.toNamed('/signup');
                      },
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Điều khoản sử dụng"),
                      SizedBox(width: 20),
                      Text('Chính sách bảo mật'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// TextFormField(
// decoration: InputDecoration(
// isDense: true,
// filled: true,
// fillColor: Colors.white,
// hintText: 'Search',
// hintStyle: Theme.of(context)
//     .textTheme
//     .bodyMedium!
//     .copyWith(color: Colors.grey.shade400),
// prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15.0),
// borderSide: BorderSide.none,
// ),
// ),
// ),
