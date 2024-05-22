import 'dart:async';

import 'package:music_app_project/repositories/song_repository.dart';

import '../models/song.dart';

class SongViewModel {
  StreamController<List<Song>> songStream = StreamController();

  Future<void> loadSong() async {
    final songRepository = SongRepository();
    songRepository.loadDataRepository().then(
          (song) => songStream.add(song!),
        );
  }
}
