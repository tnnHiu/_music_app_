import 'package:music_app_project/models/models.dart';
import 'package:music_app_project/services/source_services/source_service.dart';

class PlaylistRepository {
  final _playlistSource = SourceService();

  Future<List<Playlist>?> loadPlaylistRepository() async {
    List<Playlist> playlists = [];
    await _playlistSource.loadplaylist().then(
      (playlist) {
        if (playlist != null) {
          playlists.addAll(playlist);
        }
      },
    );
    return playlists;
  }
}
