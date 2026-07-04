import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/constants/api_constants.dart';
import '../models/cast_member.dart';
import '../models/episode.dart';
import '../models/movie.dart';

class MovieRepository {
  const MovieRepository({required this.client});

  final http.Client client;

  // ── Busca ──────────────────────────────────────────────────────

  Future<List<Movie>> fetchMovies(String query) async {
    final url = '$searchShowsUrl$query';
    final response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Falha ao carregar filmes (${response.statusCode})');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => Movie.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // ── Elenco ─────────────────────────────────────────────────────

  Future<List<CastMember>> fetchCast(int showId) async {
    final url = '$apiBase/shows/$showId/cast';
    final response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return [];
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => CastMember.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // ── Episódios ──────────────────────────────────────────────────

  Future<List<Episode>> fetchEpisodes(int showId) async {
    final url = '$apiBase/shows/$showId/episodes';
    final response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return [];
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => Episode.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // ── Programação ────────────────────────────────────────────────

  Future<List<ScheduleEpisode>> fetchSchedule(String countryCode) async {
    final url = '$scheduleUrl$countryCode';
    final response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Falha ao carregar programacao (${response.statusCode})');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) =>
            ScheduleEpisode.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

// ── Modelo para episódio da programação (embed show) ─────────────

class ScheduleEpisode {
  final int id;
  final String name;
  final int season;
  final int number;
  final String? airdate;
  final String? airtime;
  final String? image;
  final int showId;
  final String showName;
  final String? showImage;

  const ScheduleEpisode({
    required this.id,
    required this.name,
    required this.season,
    required this.number,
    this.airdate,
    this.airtime,
    this.image,
    required this.showId,
    required this.showName,
    this.showImage,
  });

  factory ScheduleEpisode.fromJson(Map<String, dynamic> json) {
    final image = json['image'] as Map<String, dynamic>?;
    final show = json['show'] as Map<String, dynamic>? ?? {};
    final showImage = (show['image'] as Map<String, dynamic>?) ?? {};

    return ScheduleEpisode(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Sem nome',
      season: json['season'] as int? ?? 0,
      number: json['number'] as int? ?? 0,
      airdate: json['airdate'] as String?,
      airtime: json['airtime'] as String?,
      image: image?['medium'] as String? ?? showImage['medium'] as String?,
      showId: show['id'] as int? ?? 0,
      showName: show['name'] as String? ?? 'Desconhecido',
      showImage: showImage['medium'] as String?,
    );
  }
}
