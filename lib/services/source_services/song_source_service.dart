import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_app_project/constants/app_constants.dart';

import "../../models/models.dart";
// lay du lieu bai hat

abstract interface class SongSource {
  Future<List<Song>?> loadData();
}

class SongSourceImpl implements SongSource {
  @override
  Future<List<Song>?> loadData() async {
    final url = Uri.parse(apiUrlSong);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      var songWrapper = jsonDecode(bodyContent) as Map;
      var songList = songWrapper['songs'] as List;
      List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
      return songs;
    } else {
      return null;
    }
  }
}
