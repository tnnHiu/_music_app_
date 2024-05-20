import 'package:music_app_project/services/source_services/source_service.dart';

import '../models/song.dart';

abstract interface class SongRepository {
  Future<List<Song>?> loadDataRepository();
}

class SongRepositoryImpl implements SongRepository {
  final _songSource = SourceServiceImpl();

  @override
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
