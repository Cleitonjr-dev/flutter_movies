import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/constants/api_constants.dart';
import '../models/movie.dart';

class MovieRepository {
  const MovieRepository({required this.client});

  final http.Client client;

  Future<List<Movie>> fetchMovies(String query) async {
    final url = '$baseUrl$query';
    final response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Falha ao carregar filmes (${response.statusCode})');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => Movie.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
