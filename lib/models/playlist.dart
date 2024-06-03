import '../models/models.dart';

class Playlist {
  final String title;
  final List<Song> songs;
  final String imageUrl;

  Playlist({
    required this.title,
    required this.songs,
    required this.imageUrl,
  });

  static List<Playlist> playlists = [
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
