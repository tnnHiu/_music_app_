import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app_project/views/screens/auth_screen/signup_screen.dart';
import 'package:music_app_project/views/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: ThemeData(
        // textTheme: Theme.of(context).textTheme.apply(
        //       bodyColor: Colors.white,
        //       displayColor: Colors.white,
        //     ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
        ),
      ),
      // home: const LoginSignupScreen(),
      home: const LoginScreen(),
      getPages: [
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/song', page: () => const SongScreen()),
        GetPage(name: '/playlist', page: () => const PlaylistScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignupScreen()),
      ],
    );
  }
}
