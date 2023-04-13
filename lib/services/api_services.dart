import 'package:http/http.dart' as http;

// A URL da API
const baseUrl = "https://api.tvmaze.com/search/shows?q=";

// Criamos a classe da nossa API. O nome você que escolhe. Fazemos aqui
// uma requisição get (como fizemos no react) e passamos a URL, mas usamos
// um Uri.parse pra transformar a string em uma URI.
class API {
  static Future getMovie(search) async {
    var url = baseUrl + search;
    return await http.get(Uri.parse(url));
  }
}

// Criamos uma classe para representar os objetos que vão conter os filmes
// e colocamos só os campos que vamos usar.
class Movie {
  int id;
  String name;
  String link;
  String image;

  Movie(this.id, this.name, this.link, this.image);

  Movie.fromJson(Map json)
      : id = json['show']['id'],
        name = json['show']['name'],
        link = json['show']['url'],
        image = json['show']['image']['medium'];
}