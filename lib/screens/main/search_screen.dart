import 'package:curve_navbar/Models/movie_model.dart';
import 'package:curve_navbar/screens/main/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchMoviesPageState();
}

class _SearchMoviesPageState extends State<SearchScreen> {
  List<Movie> filteredMovies = [];
  TextEditingController searchController = TextEditingController();
  String searchMessage = '';

  Timer? _debounce; // For debouncing search input

  @override
  void initState() {
    super.initState();
    filteredMovies = List.from(availableMovie);
    searchMessage = 'Showing all movies';
  }

  void searchMovies(String query) {
    query = query.trim(); // Handle whitespace

    if (query.isEmpty) {
      setState(() {
        filteredMovies = List.from(availableMovie);
        searchMessage = 'Showing all movies';
      });
      return;
    }

    final searchLower = query.toLowerCase();
    final results = availableMovie.where((movie) {
      final titleLower = movie.title.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredMovies = results;
      searchMessage = results.isEmpty
          ? "No movies found matching '$query'"
          : "Found ${results.length} ${results.length == 1 ? 'movie' : 'movies'}";
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090E17),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E2433),
        title: TextField(
          controller: searchController,
          onChanged: (query) {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 300), () {
              if (mounted) searchMovies(query);
            });
          },
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search movies.... ",
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search, color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                searchMessage,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: filteredMovies.isEmpty
                  ? const Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredMovies.length,
                      itemBuilder: (context, index) {
                        final movie = filteredMovies[index];
                        return GestureDetector(
                          onTap: () => Get.to(
                            () => DetailScreen(movie: filteredMovies[index]),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E2433),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.3),
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      movie.poster,
                                      width: 50,
                                      height: 75,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "${movie.genre} - ⭐ ${movie.rating}",
                                          style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
