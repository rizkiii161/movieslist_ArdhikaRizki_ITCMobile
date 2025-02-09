import 'package:flutter/material.dart';
import 'package:movieslist/services/api_service.dart';
import 'package:movieslist/views/movie_detail_screen.dart';
import 'package:movieslist/services/constans.dart';

class DiscoverMoviesScreen extends StatefulWidget {
  const DiscoverMoviesScreen({super.key});

  @override
  State<DiscoverMoviesScreen> createState() => _DiscoverMoviesScreenState();
}

class _DiscoverMoviesScreenState extends State<DiscoverMoviesScreen> {
  List<dynamic> movies = [];
  List<dynamic> filteredMovies = [];
  Map<int, String> genreMap = {};
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMoviesAndGenres();
    _searchController.addListener(_filterMovies);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchMoviesAndGenres() async {
    try {
      final fetchedMovies = await ApiService.fetchTrendingMovies(page: 1);
      final fetchedMoviesPage2 = await ApiService.fetchTrendingMovies(page: 2);
      final fetchedMoviesPage3 = await ApiService.fetchTrendingMovies(page: 3);
      final fetchedMoviesPage4 = await ApiService.fetchTrendingMovies(page: 4);
      final fetchedMoviesPage5 = await ApiService.fetchTrendingMovies(page: 5);
      final fetchedGenres = await ApiService.fetchGenres();

      setState(() {
        movies = [...fetchedMovies, ...fetchedMoviesPage2, ...fetchedMoviesPage3, ...fetchedMoviesPage4, ...fetchedMoviesPage5];
        filteredMovies = movies;
        genreMap = fetchedGenres;
      });
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  void _filterMovies() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredMovies = movies.where((movie) {
        final title = movie["title"]?.toLowerCase() ?? "";
        return title.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        title: Text("Discover Movies", style: TextStyle(color: ktextcolor)),
        backgroundColor: Kprimarycolor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search movies...",
                prefixIcon: Icon(Icons.search, color: ktextcolor),
                filled: true,
                fillColor: ksecondarycolor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: ktextcolor),
            ),
          ),
          Expanded(
            child: filteredMovies.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: filteredMovies.length,
                    itemBuilder: (context, index) {
                      final movie = filteredMovies[index];
                      final movieTitle = movie["title"] ?? "No Title";
                      final moviePoster = "https://image.tmdb.org/t/p/w500${movie["poster_path"]}";
                      final movieOverview = movie["overview"] ?? "No description available";
                      final genreIds = movie["genre_ids"] as List<dynamic>? ?? [];
                      final movieGenres = genreIds.map((id) => genreMap[id] ?? "").join(", ");

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailScreen(
                                title: movieTitle,
                                genre: movieGenres,
                                imageUrl: moviePoster,
                                overview: movieOverview,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: ksecondarycolor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                child: Image.network(moviePoster, height: 180, width: double.infinity, fit: BoxFit.cover),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movieTitle,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ktextcolor),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      movieGenres.isNotEmpty ? movieGenres : "No Genre",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 12, color: ktextcolor.withOpacity(0.7)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
