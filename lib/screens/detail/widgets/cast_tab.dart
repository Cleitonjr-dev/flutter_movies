import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/cast_member.dart';
import '../../../repositories/movie_repository.dart';

class CastTab extends StatefulWidget {
  const CastTab({required this.showId, super.key});

  final int showId;

  @override
  State<CastTab> createState() => _CastTabState();
}

class _CastTabState extends State<CastTab> {
  final _repository = MovieRepository(client: http.Client());

  List<CastMember> _cast = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCast();
  }

  Future<void> _loadCast() async {
    try {
      final cast = await _repository.fetchCast(widget.showId);
      if (mounted) setState(() { _cast = cast; _isLoading = false; });
    } catch (e) {
      if (mounted) {
        setState(() { _error = 'Erro ao carregar elenco'; _isLoading = false; });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null || _cast.isEmpty) {
      return Center(
        child: Text(
          _error ?? 'Elenco nao disponivel',
          style: TextStyle(color: cs.onSurfaceVariant),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: _cast.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final member = _cast[index];

        return ListTile(
          leading: CircleAvatar(
            radius: 24,
            backgroundImage: member.personImage != null
                ? NetworkImage(member.personImage!)
                : null,
            child: member.personImage == null
                ? Icon(Icons.person, color: cs.onSurfaceVariant)
                : null,
            onBackgroundImageError: (_, __) {},
          ),
          title: Text(
            member.personName,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
          subtitle: Text(
            member.characterName,
            style: TextStyle(color: cs.primary),
          ),
        );
      },
    );
  }
}
