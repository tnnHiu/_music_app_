import 'package:music_app_project/models/song.dart';

class RecommendSong {
  final List<Song> songsRate;
  final List<Song> songsView;

  RecommendSong({
    required this.songsRate,
    required this.songsView,
  });
}
