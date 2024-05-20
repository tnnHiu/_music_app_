import 'dart:async';

import 'package:music_app_project/repositories/artist_repository.dart';

import '../models/artist.dart';

class ArtistViewModel {
  StreamController<List<Artist>> artistStream = StreamController();

  Future<void> loadArtist() async {
    final artistRepository = ArtistRepositoryImpl();
    artistRepository.loadArtistRepository().then(
          (artist) => artistStream.add(artist!),
        );
  }
}
