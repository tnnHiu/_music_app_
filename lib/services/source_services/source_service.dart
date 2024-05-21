import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_app_project/constants/app_constants.dart';
import 'package:music_app_project/models/genre.dart';

import '../../models/artist.dart';
import "../../models/models.dart";
import '../auth_services/auth.dart';
// lay du lieu bai hat

abstract interface class SourceService {
  Future<List<Song>?> loadSong();

  Future<List<Genre>?> loadGenre();

  Future<List<Artist>?> loadArtist();
}

class SourceServiceImpl implements SourceService {
  @override
  Future<List<Song>?> loadSong() async {
    final url = Uri.parse('${apiUrl}song');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      var songWrapper = jsonDecode(bodyContent) as Map;
      var songList = songWrapper['listResult'] as List;
      List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
      return songs;
    } else {
      return null;
    }
  }

  @override
  Future<List<Genre>?> loadGenre() async {
    final url = Uri.parse('${apiUrl}genre');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      var genreWrapper = jsonDecode(bodyContent) as Map;
      var genreList = genreWrapper['listResult'] as List;
      List<Genre> genres =
          genreList.map((genre) => Genre.fromJson(genre)).toList();
      return genres;
    } else {
      return null;
    }
  }

  @override
  Future<List<Artist>?> loadArtist() async {
    final url = Uri.parse('${apiUrl}artist');
    String? token = await Auth.readCache(key: 'token');
    var headers = {'token': token.toString()};
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      var artistWrapper = jsonDecode(bodyContent) as Map;
      var artistList = artistWrapper['listResult'] as List;
      List<Artist> artists =
          artistList.map((artist) => Artist.fromJson(artist)).toList();
      return artists;
    } else {
      return null;
    }
  }
}
