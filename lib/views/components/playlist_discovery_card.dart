import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_project/models/models.dart';

class PlaylistDiscoveryCard extends StatelessWidget {
  const PlaylistDiscoveryCard({
    super.key,
    required this.playlist,
  });

  final Playlist playlist;

  get songIndex => null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/playlist', arguments: playlist);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: NetworkImage(playlist.songs[1].urlThumbnail),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width * 0.37,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white.withOpacity(0.8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      // child: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       currentSong.artist,
                      //       overflow: TextOverflow.ellipsis,
                      //       style:
                      //           Theme.of(context).textTheme.bodyLarge!.copyWith(
                      //                 color: Colors.deepPurple,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //     ),
                      //     Text(
                      //       currentSong.title,
                      //       overflow: TextOverflow.ellipsis,
                      //       style:
                      //           Theme.of(context).textTheme.bodyLarge!.copyWith(
                      //                 color: Colors.white,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //     ),
                      //   ],
                      // ),
                    ),
                  ),
                  // const Expanded(
                  //   child: Icon(
                  //     Icons.play_circle,
                  //     color: Colors.deepPurple,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
