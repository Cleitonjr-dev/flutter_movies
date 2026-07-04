class Movie {
  final int id;
  final String name;
  final String link;
  final String image;
  final String? imageOriginal;
  final String summary;
  final List<String> genres;
  final double? rating;
  final String status;
  final String? premiered;
  final String? network;
  final String? language;
  final int? runtime;
  final String? officialSite;

  const Movie({
    required this.id,
    required this.name,
    required this.link,
    required this.image,
    this.imageOriginal,
    required this.summary,
    required this.genres,
    this.rating,
    required this.status,
    this.premiered,
    this.network,
    this.language,
    this.runtime,
    this.officialSite,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final show = json['show'] as Map<String, dynamic>;
    final image = show['image'] as Map<String, dynamic>?;
    final ratingMap = show['rating'] as Map<String, dynamic>?;
    final networkMap = show['network'] as Map<String, dynamic>?;

    return Movie(
      id: show['id'] as int,
      name: show['name'] as String? ?? 'Sem nome',
      link: show['url'] as String? ?? '',
      image: image?['medium'] as String? ??
          'https://via.placeholder.com/210x295?text=No+Image',
      imageOriginal: image?['original'] as String?,
      summary: _stripHtml(show['summary'] as String? ?? ''),
      genres: (show['genres'] as List<dynamic>?)
              ?.map((g) => g.toString())
              .toList() ??
          [],
      rating: (ratingMap?['average'] as num?)?.toDouble(),
      status: show['status'] as String? ?? 'Desconhecido',
      premiered: show['premiered'] as String?,
      network: networkMap?['name'] as String?,
      language: show['language'] as String?,
      runtime: show['runtime'] as int?,
      officialSite: show['officialSite'] as String?,
    );
  }

  factory Movie.fromShowJson(Map<String, dynamic> show) {
    final image = show['image'] as Map<String, dynamic>?;
    final ratingMap = show['rating'] as Map<String, dynamic>?;
    final networkMap = show['network'] as Map<String, dynamic>?;

    return Movie(
      id: show['id'] as int,
      name: show['name'] as String? ?? 'Sem nome',
      link: show['url'] as String? ?? '',
      image: image?['medium'] as String? ??
          'https://via.placeholder.com/210x295?text=No+Image',
      imageOriginal: image?['original'] as String?,
      summary: _stripHtml(show['summary'] as String? ?? ''),
      genres: (show['genres'] as List<dynamic>?)
              ?.map((g) => g.toString())
              .toList() ??
          [],
      rating: (ratingMap?['average'] as num?)?.toDouble(),
      status: show['status'] as String? ?? 'Desconhecido',
      premiered: show['premiered'] as String?,
      network: networkMap?['name'] as String?,
      language: show['language'] as String?,
      runtime: show['runtime'] as int?,
      officialSite: show['officialSite'] as String?,
    );
  }

  static String _stripHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&apos;', "'")
        .trim();
  }
}
