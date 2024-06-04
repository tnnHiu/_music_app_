import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:music_app_project/constants/app_constants.dart';
import 'package:music_app_project/services/auth_services/auth.dart';

import '../models/song.dart';

class AudioPlayerController extends GetxController {
  AudioPlayer? audioPlayer = AudioPlayer();
  int currentSongIndex = 0;

  AudioPlayerController() {
    audioPlayer = AudioPlayer();
  }

  @override
  void onClose() {
    super.onClose();
    stopAndDisposePlayer();
  }

  void updateCurrentSongIndex(int index) {
    currentSongIndex = index;
  }

  Future<void> stopAndDisposePlayer() async {
    await audioPlayer?.stop();
    await audioPlayer?.dispose();
    audioPlayer = null;
  }

  Future<void> initializePlayer(List<Song> songs, int initialIndex) async {
    audioPlayer ??= AudioPlayer();
    final playlist = ConcatenatingAudioSource(children: []);
    for (Song song in songs) {
      playlist.add(
        AudioSource.uri(
          Uri.parse(song.urlAudio),
          tag: MediaItem(
            id: song.id.toString(),
            artist: song.artistName,
            title: song.title,
            artUri: Uri.parse(song.urlThumbnail),
          ),
        ),
      );
    }

    // Lắng nghe sự kiện khi một bài hát bắt đầu phát
    audioPlayer?.currentIndexStream.listen((index) {
      if (index != null) {
        final songId = songs[index].id;
        _incrementListenCount(songId);
      }
    });

    await audioPlayer?.setAudioSource(
      playlist,
      initialIndex: initialIndex,
      initialPosition: Duration.zero,
    );
    audioPlayer?.play();
  }

  void logout() async {
    await stopAndDisposePlayer();
  }

  void _incrementListenCount(int songId) async {
    String? token = await Auth.readCache(key: 'token');
    var headers = {'token': token.toString()};
    final url = '${apiUrl}song/$songId';
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        print('Successfully incremented listen count for song id: $songId');
      } else {
        print('Failed to increment listen count for song id: $songId');
      }
    } catch (e) {
      print('Error incrementing listen count for song id: $songId: $e');
    }
  }
}
