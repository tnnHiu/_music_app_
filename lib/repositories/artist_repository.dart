import 'package:music_app_project/models/artist.dart';

import '../services/source_services/source_service.dart';

class ArtistRepository {
  final _artistSource = SourceService();

  Future<List<Artist>?> loadArtistRepository() async {
    List<Artist> artists = [];
    await _artistSource.loadArtist().then(
      (artist) {
        if (artist != null) {
          artists.addAll(artist);
        }
      },
    );
    return artists;
  }
}
