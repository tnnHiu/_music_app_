import 'package:music_app_project/models/genre.dart';
import 'package:music_app_project/services/source_services/source_service.dart';

abstract interface class GenreRepository {
  Future<List<Genre>?> loadGenreRepository();
}

class GenreRepositoryImpl implements GenreRepository {
  final _genreSource = SourceServiceImpl();

  @override
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
