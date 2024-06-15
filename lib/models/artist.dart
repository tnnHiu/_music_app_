class Artist {
  final int id;
  final String name;

  Artist({
    required this.id,
    required this.name,
  });

  factory Artist.fromJson(Map<String, dynamic> map) {
    return Artist(
      id: map['id'] as int,
      name: map['name'],
    );
  }
}
