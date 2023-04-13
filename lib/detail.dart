import 'package:flutter/material.dart';
import 'package:flutter_movies/services/api_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';


// Uma página para mostrar os detalhes de cada filme. Passamos o objeto
// do filme como parâmetro no constructor
class DetailPage extends StatelessWidget {
  final Movie movie;

  const DetailPage(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.name),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Center(
              child: Image(
                image: NetworkImage(
                  movie.image,
                ),
              ),
            ),
            const Text("Link:"),
            // Aqui a gente coloca um link clicável.
            Linkify(
              onOpen: (link) async {
                Uri link = Uri.parse(movie.link);
                if (await canLaunchUrl(link)) {
                  await launchUrl(link);
                } else {
                  throw 'Não foi possível abrir {$movie.link}';
                }
              },
              text: movie.link,
            ),
          ],
        ),
      ),
    );
  }
}