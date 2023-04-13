import 'package:flutter/material.dart';
import 'movies.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  build(context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Filmes',
      home: MoviesListView(),
    );
  }
}