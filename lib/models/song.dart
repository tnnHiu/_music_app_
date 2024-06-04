// class Song {
//   final String id;
//   final String title;
//   final String artist;
//   final String source;
//   final String image;
//   final String genreId;
//   final String artistId;
//   final String description;
//
//   Song({
//     required this.id,
//     required this.title,
//     this.artist = '',
//     required this.source,
//     required this.image,
//     this.genreId = '',
//     this.artistId = '',
//     this.description = '',
//   });
//
//   factory Song.fromJson(Map<String, dynamic> map) {
//     return Song(
//       title: map['title'],
//       id: map['id'],
//       source: map['source'],
//       image: map['image'],
//     );
//   }
// }
import '../constants/app_constants.dart';

class Song {
  final int id;
  final String title;
  final String description;
  final String urlThumbnail;
  final String urlAudio;
  final String genreName;
  final String artistName;

  Song({
    required this.id,
    required this.title,
    required this.description,
    required this.urlThumbnail,
    required this.urlAudio,
    required this.genreName,
    required this.artistName,
  });

  factory Song.fromJson(Map<String, dynamic> map) {
    return Song(
      id: map['id'] as int,
      title: map['title'],
      description: map['description'],
      urlThumbnail: apiUrl + map['url_thumbnail'],
      urlAudio: apiUrl + map['url_audio'],
      genreName: map['genreDTO']['name'],
      artistName: map['artistDTO']['name'],
    );
  }
}
