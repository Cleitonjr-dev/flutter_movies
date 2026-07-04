import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../core/theme/app_theme.dart';
import '../../repositories/movie_repository.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final _repository = MovieRepository(client: http.Client());

  List<ScheduleEpisode> _episodes = [];
  bool _isLoading = true;
  String? _error;
  String _country = 'US';

  static const _countries = {
    'US': 'Estados Unidos',
    'GB': 'Reino Unido',
    'BR': 'Brasil',
    'CA': 'Canada',
    'AU': 'Australia',
    'JP': 'Japao',
    'DE': 'Alemanha',
    'FR': 'Franca',
    'IT': 'Italia',
    'ES': 'Espanha',
    'PT': 'Portugal',
    'MX': 'Mexico',
  };

  @override
  void initState() {
    super.initState();
    _loadSchedule();
  }

  Future<void> _loadSchedule() async {
    setState(() { _isLoading = true; _error = null; });

    try {
      final episodes = await _repository.fetchSchedule(_country);
      if (mounted) {
        setState(() { _episodes = episodes; _isLoading = false; });
      }
    } catch (e) {
      if (mounted) {
        setState(() { _error = 'Erro ao carregar programacao'; _isLoading = false; });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Programacao de Hoje'),
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: brightness == Brightness.dark
                ? AppColors.darkGradient
                : AppColors.primaryGradient,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              brightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode,
            ),
            tooltip:
                brightness == Brightness.dark ? 'Modo claro' : 'Modo escuro',
            onPressed: themeNotifier.toggle,
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Seletor de país ──────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: cs.surfaceContainerLow,
            child: Row(
              children: [
                Icon(Icons.public, color: cs.primary),
                const SizedBox(width: 12),
                Text('Pais:', style: TextStyle(color: cs.onSurfaceVariant)),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButton<String>(
                    value: _country,
                    isExpanded: true,
                    underline: const SizedBox(),
                    style: TextStyle(color: cs.onSurface, fontSize: 15),
                    items: _countries.entries
                        .map((e) => DropdownMenuItem(
                              value: e.key,
                              child: Text(e.value),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _country = value);
                        _loadSchedule();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // ── Lista ────────────────────────────────────
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    final cs = Theme.of(context).colorScheme;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error!, style: TextStyle(color: cs.error)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loadSchedule,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    if (_episodes.isEmpty) {
      return const Center(
        child: Text('Nenhum episodio na programacao de hoje'),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: _episodes.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final ep = _episodes[index];

        return ListTile(
          leading: CircleAvatar(
            radius: 24,
            backgroundImage:
                ep.showImage != null ? NetworkImage(ep.showImage!) : null,
            child: ep.showImage == null
                ? Icon(Icons.tv, color: cs.onSurfaceVariant)
                : null,
          ),
          title: Text(
            ep.showName,
            style: TextStyle(fontWeight: FontWeight.w600, color: cs.onSurface),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ep.name, style: TextStyle(color: cs.primary)),
              if (ep.airtime != null)
                Text(
                  'S${ep.season.toString().padLeft(2, '0')}E${ep.number.toString().padLeft(2, '0')}  ${ep.airtime}',
                  style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                ),
            ],
          ),
          isThreeLine: ep.airtime != null,
        );
      },
    );
  }
}
