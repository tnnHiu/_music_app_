// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:just_audio_background/just_audio_background.dart';
// import 'package:music_app_project/controllers/audio_player_controller.dart';
// import 'package:music_app_project/views/components/app_appbar.dart';
// import 'package:music_app_project/views/screens/auth_screen/login_screen.dart';
// import 'package:music_app_project/views/screens/auth_screen/signup_screen.dart';
// import 'package:music_app_project/views/screens/discovery_screen.dart';
// import 'package:music_app_project/views/screens/home_screen.dart';
// import 'package:music_app_project/views/screens/playlist_screen.dart';
// import 'package:music_app_project/views/screens/song_screen.dart';
// import 'package:music_app_project/views/screens/upload_song_screen.dart';
// import 'package:music_app_project/views/screens/user_screen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await JustAudioBackground.init(
//       androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
//       androidNotificationChannelName: 'Audio playback',
//       androidNotificationOngoing: true,
//     );
//     runApp(const MyApp());
//   } catch (e, stack) {
//     print('Error initializing JustAudioBackground: $e');
//     print(stack);
//     // runApp(const MyApp());
//   }
//   // runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // audio handler
//     // Chạy xuyên suốt ứng dụng
//     Get.put(AudioPlayerController());
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Music App',
//       theme: ThemeData(
//         textTheme: GoogleFonts.poppinsTextTheme(
//           Theme.of(context).textTheme.apply(
//                 bodyColor: Colors.white,
//                 displayColor: Colors.white,
//               ),
//         ),
//       ),
//       // home: const UploadSongScreen(),
//       home: const LoginScreen(),
//       getPages: [
//         GetPage(name: '/home', page: () => const AppMainScreen()),
//         GetPage(name: '/song', page: () => const SongScreen()),
//         GetPage(name: '/playlist', page: () => const PlaylistScreen()),
//         GetPage(name: '/login', page: () => const LoginScreen()),
//         GetPage(name: '/signup', page: () => const SignupScreen()),
//         GetPage(name: '/upload_song', page: () => const UploadSongScreen()),
//       ],
//     );
//   }
// }
//
// class AppMainScreen extends StatefulWidget {
//   const AppMainScreen({super.key});
//
//   @override
//   State<AppMainScreen> createState() => _AppMainScreenState();
// }
//
// class _AppMainScreenState extends State<AppMainScreen> {
//   int _selectedIndex = 0;
//   final List _tabs = [
//     const HomeScreen(),
//     const DiscoveryScreen(),
//     const UserScreen(),
//   ];
//
//   void _onItemTaped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppbar(),
//       body: _tabs.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.deepPurple.shade800,
//         unselectedItemColor: Colors.white,
//         selectedItemColor: Colors.white,
//         showUnselectedLabels: false,
//         showSelectedLabels: false,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.play_circle_outlined),
//             label: 'Play',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people_outline),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTaped,
//       ),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_app_project/controllers/audio_player_controller.dart';
import 'package:music_app_project/views/components/app_appbar.dart';
import 'package:music_app_project/views/screens/auth_screen/login_screen.dart';
import 'package:music_app_project/views/screens/auth_screen/signup_screen.dart';
import 'package:music_app_project/views/screens/discovery_screen.dart';
import 'package:music_app_project/views/screens/home_screen.dart';
import 'package:music_app_project/views/screens/playlist_screen.dart';
import 'package:music_app_project/views/screens/song_screen.dart';
import 'package:music_app_project/views/screens/upload_song_screen.dart';
import 'package:music_app_project/views/screens/user_screen.dart';
import 'package:universal_platform/universal_platform.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb || !UniversalPlatform.isWindows ) {
    try {
      await JustAudioBackground.init(
        androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
      );
    } catch (e, stack) {
      print('Error initializing JustAudioBackground: $e');
      print(stack);
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Chạy xuyên suốt ứng dụng
    Get.put(AudioPlayerController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
      ),
      home: const LoginScreen(),
      getPages: [
        GetPage(name: '/home', page: () => const AppMainScreen()),
        GetPage(name: '/song', page: () => const SongScreen()),
        GetPage(name: '/playlist', page: () => const PlaylistScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignupScreen()),
        GetPage(name: '/upload_song', page: () => const UploadSongScreen()),
      ],
    );
  }
}

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int _selectedIndex = 0;
  final List _tabs = [
    const HomeScreen(),
    const DiscoveryScreen(),
    const UserScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: _tabs.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurple.shade800,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outlined),
            label: 'Play',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

