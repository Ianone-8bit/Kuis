import 'package:flutter/material.dart';
import '/models/movie_model.dart';
import 'movie_detail_page.dart';

class MovieListPage extends StatefulWidget {
  final String username;

  const MovieListPage({super.key, required this.username});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  Set<int> addedMovies = {}; // State untuk track film yang ditambahkan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.username}"),
      ),
      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          final movie = movieList[index];
          final isAdded = addedMovies.contains(index);

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(
                movie.imgUrl,
                width: 60,
                fit: BoxFit.cover,
              ),
              title: Text(movie.title),
              subtitle: Text(
                "${movie.year} • ${movie.genre}",
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    movie.rating.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (isAdded) {
                          addedMovies.remove(index);
                        } else {
                          addedMovies.add(index);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isAdded ? Colors.blue : Colors.white,
                      side: BorderSide(
                        color: isAdded ? Colors.blue : Colors.black,
                      ),
                    ),
                    child: Text(
                      isAdded ? "Sudah Ditambahkan" : "Tambahkan ke Daftar",
                      style: TextStyle(
                        color: isAdded ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailPage(movie: movie),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}