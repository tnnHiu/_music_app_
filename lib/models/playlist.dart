import '../models/models.dart';

class PlayList {
  final String title;
  final List<Song> songs;
  final String imageUrl;

  PlayList({
    required this.title,
    required this.songs,
    required this.imageUrl,
  });

  static List<PlayList> playlists = [
    // PlayList(
    //   title: 'Rock Ballad',
    //   songs: Song.songs,
    //   imageUrl: 'assets/images/chillies.jpg',
    // ),
    // PlayList(
    //   title: 'Pop',
    //   songs: Song.songs,
    //   imageUrl: 'assets/images/sontung.jpg',
    // ),
    // PlayList(
    //   title: 'Ballad',
    //   songs: Song.songs,
    //   imageUrl: 'assets/images/trungquan.jpg',
    // ),
  ];
}
