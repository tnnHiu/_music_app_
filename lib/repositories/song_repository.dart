import 'package:music_app_project/services/source_services/song_source_service.dart';

import '../models/song.dart';

abstract interface class SongRepository {
  Future<List<Song>?> loadDataRepository();
}

class SongRepositoryImpl implements SongRepository {
  final _songSource = SongSourceImpl();

  @override
  Future<List<Song>?> loadDataRepository() async {
    List<Song> songs = [];
    await _songSource.loadData().then(
      (song) {
        if (song != null) {
          songs.addAll(song);
        }
      },
    );
    return songs;
  }
}
