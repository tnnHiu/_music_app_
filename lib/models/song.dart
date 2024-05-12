class Song {
  final String title;
  final String description;
  final String url;
  final String coverUrl;

  Song({
    required this.title,
    required this.description,
    required this.url,
    required this.coverUrl,
  });

  static List<Song> songs = [
    Song(
      title: 'Vung ky uc',
      description: 'Vung ky uc xua',
      url: 'assets/songs/Vung_Ky_Uc.mp3',
      coverUrl: 'assets/images/chillies.jpg',
    ),
    Song(
      title: 'Muon roi ma sao con',
      description: 'Nhin len tran nha roi quay ra',
      url: 'assets/songs/Muon_Roi_Ma_Sao_Con.mp3',
      coverUrl: 'assets/images/sontung.jpg',
    ),
    Song(
      title: 'Mot ngan noi dau',
      description: 'Vi anh cung chi la nguoi den sau',
      url: 'assets/songs/Mot_Ngan_Noi_Dau.mp3',
      coverUrl: 'assets/images/trungquan.jpg',
    ),
  ];
}
