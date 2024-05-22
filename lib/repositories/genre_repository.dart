import 'package:music_app_project/models/genre.dart';
import 'package:music_app_project/services/source_services/source_service.dart';

class GenreRepository {
  final _genreSource = SourceService();

  Future<List<Genre>?> loadGenreRepository() async {
    List<Genre> genres = [];
    await _genreSource.loadGenre().then(
      (genre) {
        if (genre != null) {
          genres.addAll(genre);
        }
      },
    );
    return genres;
  }
}
