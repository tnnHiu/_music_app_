import 'package:music_app_project/models/recommend_song.dart';
import 'package:music_app_project/services/source_services/source_service.dart';

import '../models/song.dart';

class RecommendSongRepository {
  final _recommendSongSource = SourceService();

  Future<RecommendSong?> loadRecommendSongRepository() async {
    List<Song> songsRate = [];
    List<Song> songsView = [];
    await _recommendSongSource.loadRecommendSong().then((recommendSong) {
      if (recommendSong != null) {
        songsRate.addAll(recommendSong.songsRate);
        songsView.addAll(recommendSong.songsView);
      }
    });
    return RecommendSong(
      songsRate: songsRate,
      songsView: songsView,
    );
  }
}
