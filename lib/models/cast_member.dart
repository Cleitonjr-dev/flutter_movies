class CastMember {
  final int personId;
  final String personName;
  final String? personImage;
  final int characterId;
  final String characterName;
  final String? characterImage;

  const CastMember({
    required this.personId,
    required this.personName,
    this.personImage,
    required this.characterId,
    required this.characterName,
    this.characterImage,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) {
    final person = json['person'] as Map<String, dynamic>;
    final character = json['character'] as Map<String, dynamic>;
    final personImage = person['image'] as Map<String, dynamic>?;
    final characterImage = character['image'] as Map<String, dynamic>?;

    return CastMember(
      personId: person['id'] as int,
      personName: person['name'] as String? ?? 'Desconhecido',
      personImage: personImage?['medium'] as String?,
      characterId: character['id'] as int,
      characterName: character['name'] as String? ?? 'Desconhecido',
      characterImage: characterImage?['medium'] as String?,
    );
  }
}
