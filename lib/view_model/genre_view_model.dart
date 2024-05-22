import 'dart:async';

import 'package:music_app_project/models/genre.dart';
import 'package:music_app_project/repositories/genre_repository.dart';

class GenreViewModel {
  StreamController<List<Genre>> genreStream = StreamController();

  Future<void> loadGenre() async {
    final genreRepository = GenreRepository();
    genreRepository.loadGenreRepository().then(
          (genre) => genreStream.add(genre!),
        );
  }
}
