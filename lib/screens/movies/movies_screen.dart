import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../core/theme/app_theme.dart';
import '../../models/movie.dart';
import '../../repositories/movie_repository.dart';
import '../detail/detail_screen.dart';
import '../schedule/schedule_screen.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final MovieRepository _repository = MovieRepository(client: http.Client());

  List<Movie> _movies = [];
  bool _isLoading = true;
  String? _errorMessage;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  Widget _appBarTitle = const Text('Lista de Filmes');
  Icon _actionIcon = const Icon(Icons.search);
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _fetchMovies('star%20trek');
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _fetchMovies(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final movies = await _repository.fetchMovies(query);
      setState(() {
        _movies = movies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao carregar filmes: $e';
        _isLoading = false;
      });
    }
  }

  void _toggleSearch() {
    setState(() {
      if (_isSearching) {
        _isSearching = false;
        _actionIcon = const Icon(Icons.search);
        _appBarTitle = const Text('Lista de Filmes');
        _searchController.clear();
      } else {
        _isSearching = true;
        _actionIcon = const Icon(Icons.close);
        _appBarTitle = TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          autofocus: true,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            hintText: 'Search...',
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              _fetchMovies(value.trim());
              _searchFocusNode.unfocus();
            }
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        foregroundColor: _isSearching ? null : Colors.white,
        flexibleSpace: _isSearching
            ? null
            : Container(
                decoration: BoxDecoration(
                  gradient: brightness == Brightness.dark
                      ? AppColors.darkGradient
                      : AppColors.primaryGradient,
                ),
              ),
        actions: [
          IconButton(
            icon: const Icon(Icons.schedule),
            tooltip: 'Programacao de hoje',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScheduleScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            tooltip: brightness == Brightness.dark
                ? 'Modo claro'
                : 'Modo escuro',
            onPressed: themeNotifier.toggle,
          ),
          IconButton(
            icon: _actionIcon,
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _fetchMovies('star%20trek'),
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    if (_movies.isEmpty) {
      return const Center(child: Text('Nenhum filme encontrado'));
    }

    return ListView.builder(
      itemCount: _movies.length,
      itemBuilder: (context, index) {
        final movie = _movies[index];
        final colorScheme = Theme.of(context).colorScheme;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(movie.image),
              onBackgroundImageError: (_, __) {},
            ),
            title: Text(
              movie.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            subtitle: Text(
              movie.genres.isNotEmpty
                  ? movie.genres.take(3).join('  ·  ')
                  : movie.link,
              style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: colorScheme.onSurfaceVariant,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(movie: movie),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
