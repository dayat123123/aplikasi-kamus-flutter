class Kosakata {
  final String id;
  final String kata_dasar;
  final String kata_daerah;

  Kosakata({
    required this.id,
    required this.kata_dasar,
    required this.kata_daerah,
  });

  factory Kosakata.fromJson(Map<String, dynamic> json) => Kosakata(
        id: json['id'],
        kata_dasar: json['kata_dasar'],
        kata_daerah: json['kata_daerah'],
      );
}
