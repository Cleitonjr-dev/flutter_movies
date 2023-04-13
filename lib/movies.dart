
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_movies/services/api_services.dart';
import 'dart:convert';

import 'detail.dart';

// Vamos precisar de uma aplicação com estado
class MoviesListView extends StatefulWidget {
  const MoviesListView({super.key});

  @override
  State<MoviesListView> createState() => _MoviesListViewState();
}

class _MoviesListViewState extends State<MoviesListView> {
  List<Movie> movies = List<Movie>.empty(); // Lista dos filmes
  String search = "star%20trek"; // Plavra chave da pesquisa

  // Construtor, atualiza com setState a lista de filmes.
  _MoviesListViewState() {
    API.getMovie(search).then((response) {
      setState(() {
        Iterable lista = json.decode(response.body); // Usamos um iterator
        movies = lista.map((model) => Movie.fromJson(model)).toList();
      });
    });
  }
   Widget appBarTitle = Text("Lista de Filmes");
  Icon actionIcon = Icon(Icons.search);
  // Método build sobrecarregado que vai construir nossa página
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: [
        IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = Icon(Icons.close);
                this.appBarTitle = TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.white)),
                );
              } else {
                this.actionIcon = Icon(Icons.search);
                this.appBarTitle = Text("Lista de Filmes");
              }
            });
          },
        ),
      ]),
      // Aqui vem nossa lista
      body: ListView.builder(
        itemCount: movies.length, // quantidade de elementos
        // Os elementos da lista
        itemBuilder: (context, index) {
          // Vai ser um item de lista tipo ListTile
          return ListTile(
            // Uma imagem de avatar redondinho com a imagem do filme
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                movies[index].image,
              ),
            ),
            // No título é o nome do filme
            title: Text(
              movies[index].name,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
            // No subtítulo colocamos o link
            subtitle: Text(movies[index].link),
            // Ação de clicar
            onTap: () {
              // Abrimos uma nova página, outra classe, que está no arquivo
              // detail.dart. Veja que é um MaterialPageRote, tipo o
              // MaterialApp, só que é só uma página nova.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(movies[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}