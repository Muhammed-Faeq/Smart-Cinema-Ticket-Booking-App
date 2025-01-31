import 'package:curve_navbar/Models/movie_model.dart';
import 'package:curve_navbar/consts.dart';
import 'package:curve_navbar/screens/main/reservation_screen.dart';
import 'package:curve_navbar/widgets/movie_information.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.movie});
  final Movie movie;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090E17),
      appBar: AppBar(
        forceMaterialTransparency: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Movie Details",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              SizedBox(
                height: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// For Movie Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        widget.movie.poster,
                      ),
                    ),
                    const SizedBox(width: 20),

                    /// For Movie Information
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MovieInfo(
                            icon: Icons.videocam_rounded,
                            name: "Genre",
                            value: widget.movie.genre,
                          ),
                          MovieInfo(
                            icon: Icons.timer,
                            name: "Duration",
                            value: formatTime(
                              Duration(minutes: widget.movie.duration),
                            ),
                          ),
                          MovieInfo(
                            icon: Icons.star,
                            name: "Rating",
                            value: "${widget.movie.rating}/10",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              /// For Movie Title
              Text(
                widget.movie.title,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              /// For Divider
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),

              /// For Description
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 15),
              Text(
                widget.movie.description,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white60,
                  height: 2,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),

      ///for Button at the Bottom
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFffb43b),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          onPressed: () {
            Get.to(() => ReservationScreen(movieTitle: widget.movie.title));
          },
          child: const Text(
            "Get Reservation",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
