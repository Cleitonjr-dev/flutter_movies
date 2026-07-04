class Movie {
  final int id;
  final String name;
  final String link;
  final String image;

  const Movie({
    required this.id,
    required this.name,
    required this.link,
    required this.image,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final show = json['show'] as Map<String, dynamic>;
    final image = show['image'] as Map<String, dynamic>?;

    return Movie(
      id: show['id'] as int,
      name: show['name'] as String? ?? 'Sem nome',
      link: show['url'] as String? ?? '',
      image: image?['medium'] as String? ??
          'https://via.placeholder.com/210x295?text=No+Image',
    );
  }
}
