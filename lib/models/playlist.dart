import 'package:music_app_project/constants/app_constants.dart';

import '../models/models.dart';

class Playlist {
  final int id;
  final String title;
  final List<Song> songs;
  final String urlAvatar;

  Playlist({
    required this.id,
    required this.title,
    required this.songs,
    required this.urlAvatar,
  });

  factory Playlist.fromJson(
    Map<String, dynamic> map,
    Map<int, Song> songMap,
  ) {
    var songList = map['songIds'] as List;
    List<Song> songs = songList.map((songId) => songMap[songId]!).toList();
    return Playlist(
      id: map['id'] as int,
      title: map['name'],
      songs: songs,
      urlAvatar: apiUrl + map['urlAvatar'],
    );
  }
}
