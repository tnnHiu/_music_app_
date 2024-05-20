class Song {
  final String id;
  final String title;
  final String artist;
  final String source;
  final String image;
  final String genreId;
  final String artistId;
  final String description;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.source,
    required this.image,
    this.genreId = '',
    this.artistId = '',
    this.description = '',
  });

  factory Song.fromJson(Map<String, dynamic> map) {
    return Song(
      id: map['id'],
      title: map['title'],
      artist: map['artist'],
      source: map['source'],
      image: map['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url_thumbnail': image,
      'url_audio': source,
      'genreID': genreId,
      'artistID': artistId,
      'views': 0,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Song && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

// final String title;
// final String description;
// final String url;
// final String coverUrl;
//
// Song({
//   required this.title,
//   required this.description,
//   required this.url,
//   required this.coverUrl,
// });
//
// static List<Song> songs = [
//   Song(
//     title: 'Vung ky uc',
//     description: 'Vung ky uc xua',
//     url: 'assets/songs/Vung_Ky_Uc.mp3',
//     coverUrl: 'assets/images/chillies.jpg',
//   ),
//   Song(
//     title: 'Muon roi ma sao con',
//     description: 'Nhin len tran nha roi quay ra',
//     url: 'assets/songs/Muon_Roi_Ma_Sao_Con.mp3',
//     coverUrl: 'assets/images/sontung.jpg',
//   ),
//   Song(
//     title: 'Mot ngan noi dau',
//     description: 'Vi anh cung chi la nguoi den sau',
//     url: 'assets/songs/Mot_Ngan_Noi_Dau.mp3',
//     coverUrl: 'assets/images/trungquan.jpg',
//   ),
// ];
}
