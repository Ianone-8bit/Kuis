import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import ini

import '../models/movie_model.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailPage({super.key, required this.movie});

  Future<void> _launchWikipedia() async {
    final Uri url = Uri.parse(movie.movieUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              movie.imgUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("${movie.year} • ${movie.genre}"),
                  const SizedBox(height: 10),
                  Text("Rating: ${movie.rating}"), // Tambah rating di sini
                  const SizedBox(height: 10),
                  Text("Director: ${movie.director}"),
                  const SizedBox(height: 10),
                  const Text(
                    "Cast:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...movie.casts.map((c) => Text(c)),
                  const SizedBox(height: 10),
                  const Text(
                    "Synopsis:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(movie.synopsis),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _launchWikipedia,
                    child: const Text("Buka Halaman Wikipedia"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}