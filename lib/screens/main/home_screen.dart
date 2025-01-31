import 'package:curve_navbar/Models/movie_model.dart';
import 'package:curve_navbar/controller/bottom_navigation_bar_controller.dart';
import 'package:curve_navbar/screens/main/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(BTNController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090E17),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 10.0, bottom: 20.0),
          child: Text(
            "C i n e m a  T i m e",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, bottom: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  controller.changeTabIndex(4);
                });
              },
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.blueGrey.shade700,
                child: const Icon(
                  Icons.person,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///for Carousel Slider in the top
            SizedBox(
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: newMovies.length,
                itemBuilder: (context, index, realIndex) {
                  final movie = newMovies[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => DetailScreen(movie: movie));
                    },

                    ///for newMovie Image
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 2,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Stack(
                          children: [
                            Image.asset(
                              movie.poster,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),

                            /// Semi-transparent overlay for text and rating
                            Container(
                              height: 300,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),

                            ///for Movie Details
                            Positioned(
                              bottom: 20,
                              left: 10,
                              right: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    movie.description,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        movie.rating.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                    ],
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
                options: CarouselOptions(
                  height: 300,
                  autoPlay: true,
                  viewportFraction: 0.8,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  autoPlayInterval: const Duration(seconds: 5),
                  enlargeCenterPage: true,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Trending Section
            sectionWithSeeAll(
              context,
              title: "Trending",
              movies: trendingMovie,
            ),
            const SizedBox(height: 15),

            // Available Movies Section
            sectionWithSeeAll(
              context,
              title: "Available Movies",
              movies: availableMovie,
            ),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }

  Widget sectionWithSeeAll(
    BuildContext context, {
    required String title,
    required List<Movie> movies,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: movies.length + 1, // Extra item for "See All"
            itemBuilder: (context, index) {
              if (index == movies.length) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1c1c27),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 3,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }

              ///for movie poster
              final movie = movies[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => DetailScreen(movie: movies[index]));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          blurRadius: 2,
                          offset: const Offset(3, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: [
                          Image.asset(
                            movie.poster,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
