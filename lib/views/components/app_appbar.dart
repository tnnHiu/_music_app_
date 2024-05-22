import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/auth_services/auth.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.transparent,
      backgroundColor: Colors.deepPurple.shade800,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.grid_view_rounded),
        color: Colors.white,
        onPressed: () {
          Auth.logout();
        },
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: () => Get.toNamed('/upload_song'),
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://static.vecteezy.com/system/resources/thumbnails'
                  '/002/002/403/small/man-with-beard-avatar-character-'
                  'isolated-icon-free-vector.jpg'),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
