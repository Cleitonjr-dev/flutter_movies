import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../models/movie.dart';
import 'widgets/cast_tab.dart';
import 'widgets/episodes_tab.dart';
import 'widgets/info_tab.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({required this.movie, super.key});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(movie.name),
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
                brightness == Brightness.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              tooltip: brightness == Brightness.dark
                  ? 'Modo claro'
                  : 'Modo escuro',
              onPressed: themeNotifier.toggle,
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(fontSize: 13),
            tabs: [
              Tab(icon: Icon(Icons.info_outline), text: 'Info'),
              Tab(icon: Icon(Icons.people), text: 'Elenco'),
              Tab(icon: Icon(Icons.live_tv), text: 'Episodios'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            InfoTab(movie: movie),
            CastTab(showId: movie.id),
            EpisodesTab(showId: movie.id),
          ],
        ),
      ),
    );
  }
}
