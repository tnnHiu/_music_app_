import 'dart:async';

import 'package:music_app_project/models/recommend_song.dart';

import '../repositories/recommend_song_repository.dart';

class RecommendSongViewModel {
  StreamController<RecommendSong> recommendSongStream = StreamController();

  Future<void> loadRecommendSong() async {
    final recommendSongRepository = RecommendSongRepository();
    recommendSongRepository.loadRecommendSongRepository().then((recommendSong)
        {
      recommendSongStream.add(recommendSong!);
    });
  }
}
