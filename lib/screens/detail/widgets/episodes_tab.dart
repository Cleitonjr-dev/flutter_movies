import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/episode.dart';
import '../../../repositories/movie_repository.dart';

class EpisodesTab extends StatefulWidget {
  const EpisodesTab({required this.showId, super.key});

  final int showId;

  @override
  State<EpisodesTab> createState() => _EpisodesTabState();
}

class _EpisodesTabState extends State<EpisodesTab> {
  final _repository = MovieRepository(client: http.Client());

  List<Episode> _episodes = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadEpisodes();
  }

  Future<void> _loadEpisodes() async {
    try {
      final episodes = await _repository.fetchEpisodes(widget.showId);
      if (mounted) {
        setState(() {
          _episodes = episodes;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Erro ao carregar episodios';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null || _episodes.isEmpty) {
      return Center(
        child: Text(
          _error ?? 'Nenhum episodio encontrado',
          style: TextStyle(color: cs.onSurfaceVariant),
        ),
      );
    }

    final groupedBySeason = <int, List<Episode>>{};
    for (final ep in _episodes) {
      groupedBySeason.putIfAbsent(ep.season, () => []).add(ep);
    }
    final seasons = groupedBySeason.keys.toList()..sort();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: seasons.length,
      itemBuilder: (context, index) {
        final season = seasons[index];
        final episodes = groupedBySeason[season]!;

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ExpansionTile(
            title: Text(
              'Temporada $season',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cs.onSurface,
              ),
            ),
            subtitle: Text(
              '${episodes.length} episodios',
              style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13),
            ),
            children: episodes.map((ep) {
              return ListTile(
                dense: true,
                leading: CircleAvatar(
                  radius: 16,
                  backgroundColor: cs.secondaryContainer,
                  child: Text(
                    '${ep.number}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: cs.onSecondaryContainer,
                    ),
                  ),
                ),
                title: Text(
                  ep.name,
                  style: TextStyle(fontSize: 14, color: cs.onSurface),
                ),
                subtitle: ep.airdate != null
                    ? Text(ep.airdate!,
                        style: TextStyle(
                            fontSize: 12, color: cs.onSurfaceVariant))
                    : null,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
