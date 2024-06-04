import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

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
}
