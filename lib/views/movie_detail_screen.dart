import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movieslist/services/constans.dart';
import 'package:movieslist/services/movie_provider.dart';

class MovieDetailScreen extends StatelessWidget {
  final String title;
  final String genre;
  final String imageUrl;
  final String overview;

  const MovieDetailScreen({
    super.key,
    required this.title,
    required this.genre,
    required this.imageUrl,
    required this.overview,
  });

  void _addMovieToCategory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kbackgroundcolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Tambahkan ke kategori:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ktextcolor,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: Text("Watching", style: TextStyle(color: ktextcolor)),
                onTap: () {
                  Provider.of<MovieProvider>(context, listen: false).addMovie("Watching", {
                    "title": title,
                    "poster": imageUrl,
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Watched", style: TextStyle(color: ktextcolor)),
                onTap: () {
                  Provider.of<MovieProvider>(context, listen: false).addMovie("Watched", {
                    "title": title,
                    "poster": imageUrl,
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Will Watch", style: TextStyle(color: ktextcolor)),
                onTap: () {
                  Provider.of<MovieProvider>(context, listen: false).addMovie("Will Watch", {
                    "title": title,
                    "poster": imageUrl,
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        title: Text(title, style: TextStyle(color: ktextcolor)),
        iconTheme: IconThemeData(color: ktextcolor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ktextcolor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                genre,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Overview",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ktextcolor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                overview,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kbluecolor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  onPressed: () => _addMovieToCategory(context),
                  child: Text("Tambahkan ke My Movies"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
