class Episode {
  final int id;
  final String name;
  final int season;
  final int number;
  final String? airdate;
  final String? summary;
  final String? image;

  const Episode({
    required this.id,
    required this.name,
    required this.season,
    required this.number,
    this.airdate,
    this.summary,
    this.image,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    final image = json['image'] as Map<String, dynamic>?;

    return Episode(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Sem nome',
      season: json['season'] as int? ?? 0,
      number: json['number'] as int? ?? 0,
      airdate: json['airdate'] as String?,
      summary: _stripHtml(json['summary'] as String? ?? ''),
      image: image?['medium'] as String?,
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
