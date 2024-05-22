import 'package:music_app_project/services/source_services/source_service.dart';

import '../models/song.dart';

class SongRepository {
  final _songSource = SourceService();

  Future<List<Song>?> loadDataRepository() async {
    List<Song> songs = [];
    await _songSource.loadSong().then(
      (song) {
        if (song != null) {
          songs.addAll(song);
        }
      },
    );
    return songs;
  }
}
