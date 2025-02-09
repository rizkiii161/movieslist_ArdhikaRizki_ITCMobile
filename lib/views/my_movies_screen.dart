import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movieslist/services/movie_provider.dart';
import 'package:movieslist/services/constans.dart'; 

class MyMoviesScreen extends StatefulWidget {
  const MyMoviesScreen({super.key});

  @override
  State<MyMoviesScreen> createState() => _MyMoviesScreenState();
}

class _MyMoviesScreenState extends State<MyMoviesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor, 
      appBar: AppBar(
        backgroundColor: kbackgroundcolor, 
        title: Text(
          "My Movies",
          style: TextStyle(fontWeight: FontWeight.bold, color: ktextcolor),
        ),
        iconTheme: IconThemeData(color: ktextcolor), 
        bottom: TabBar(
          controller: _tabController,
          labelColor: ktextcolor, 
          unselectedLabelColor: Colors.grey[400], 
          indicatorColor: ktextcolor, 
          tabs: [
            Tab(text: "Watching"),
            Tab(text: "Watched"),
            Tab(text: "Will Watch"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildMovieList(context, "Watching"),
          buildMovieList(context, "Watched"),
          buildMovieList(context, "Will Watch"),
        ],
      ),
    );
  }

  Widget buildMovieList(BuildContext context, String category) {
    return Consumer<MovieProvider>(
      builder: (context, movieProvider, child) {
        final movies = category == "Watching"
            ? movieProvider.watchingMovies
            : category == "Watched"
                ? movieProvider.watchedMovies
                : movieProvider.willWatchMovies;

        return movies.isEmpty
            ? Center(
                child: Text(
                  "No movies in this category",
                  style: TextStyle(color: ktextcolor),
                ),
              )
            : ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: kbackgroundcolor, 
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8), 
                        child: Image.network(
                          movies[index]["poster"]!,
                          width: 50,
                          height: 75,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        movies[index]["title"]!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: ktextcolor),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
