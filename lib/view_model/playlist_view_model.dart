import 'dart:async';

import 'package:music_app_project/models/models.dart';
import 'package:music_app_project/repositories/playlist_repositoty.dart';

class PlaylistViewModel {
  StreamController<List<Playlist>> playlistStream = StreamController();

  Future<void> loadPlaylist() async {
    final playlistRepository = PlaylistRepository();
    playlistRepository.loadPlaylistRepository().then(
          (playlist) => playlistStream.add(playlist!),
        );
  }
}
