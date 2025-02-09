import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier {
  List<Map<String, String>> watchingMovies = [];
  List<Map<String, String>> watchedMovies = [];
  List<Map<String, String>> willWatchMovies = [];

  void addMovie(String category, Map<String, String> movie) {
    if (category == "Watching") {
      watchingMovies.add(movie);
    } else if (category == "Watched") {
      watchedMovies.add(movie);
    } else if (category == "Will Watch") {
      willWatchMovies.add(movie);
    }
    notifyListeners(); // Memberi tahu UI untuk update
  }
}
