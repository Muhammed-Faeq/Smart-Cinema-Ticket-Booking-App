class Movie {
  final String poster, title, genre, description;
  final double rating;
  final int duration;

  Movie({
    required this.poster,
    required this.title,
    required this.genre,
    required this.description,
    required this.rating,
    required this.duration,
  });
}

///Newest movie
List<Movie> newMovies = [
  Movie(
    poster: 'assets/movies/venom.jpg',
    title: 'Venom: The Last Dance',
    genre: 'Action',
    description: description,
    rating: 6.0,
    duration: 90,
  ),
  Movie(
    poster: 'assets/movies/gladiator.jpeg',
    title: 'Gladiator',
    genre: 'Action',
    description: description,
    rating: 6.7,
    duration: 148,
  ),
  Movie(
    poster: 'assets/movies/arcane.jpg',
    title: 'Arcane ',
    genre: 'Drama',
    description: description,
    rating: 9.0,
    duration: 120,
  ),
  Movie(
    poster: 'assets/movies/joker2.jpg',
    title: 'Joker 2',
    genre: "Drama",
    description: description,
    rating: 5.2,
    duration: 138,
  ),
  Movie(
    poster: 'assets/movies/dune2.jpg',
    title: 'Dune 2',
    genre: "Magic,",
    description: description,
    rating: 8.5,
    duration: 168,
  ),
  Movie(
    poster: 'assets/movies/furiosa.jpg',
    title: 'Furiosa: A Mad Max Saga',
    genre: "Action",
    description: description,
    rating: 7.5,
    duration: 148,
  ),
  Movie(
    poster: 'assets/movies/attack on titan.jpg',
    title: 'Attack On Titans',
    genre: 'Action',
    description: description,
    rating: 8.9,
    duration: 140,
  ),
];

///Trending movie
List<Movie> trendingMovie = [
  Movie(
    poster: 'assets/movies/furiosa.jpg',
    title: 'Furiosa: A Mad Max Saga',
    genre: "Action, Drama",
    description: description,
    rating: 7.5,
    duration: 148,
  ),
  Movie(
    poster: 'assets/movies/venom.jpg',
    title: 'Venom: The Last Dance',
    genre: 'Action',
    description: description,
    rating: 6.0,
    duration: 90,
  ),
  Movie(
    poster: 'assets/movies/gladiator.jpeg',
    title: 'Gladiator',
    genre: 'Action',
    description: description,
    rating: 6.7,
    duration: 148,
  ),
  Movie(
    poster: 'assets/movies/arcane.jpg',
    title: 'Arcane ',
    genre: 'Drama',
    description: description,
    rating: 9.0,
    duration: 120,
  ),
  Movie(
    poster: 'assets/movies/attack on titan.jpg',
    title: 'Attack On Titans',
    genre: 'Action',
    description: description,
    rating: 8.9,
    duration: 140,
  ),
];

///Available movie
List<Movie> availableMovie = [
  Movie(
    poster: 'assets/movies/venom.jpg',
    title: 'Venom: The Last Dance',
    genre: 'Action',
    description: description,
    rating: 6.0,
    duration: 90,
  ),
  Movie(
    poster: 'assets/movies/gladiator.jpeg',
    title: 'Gladiator',
    genre: 'Action',
    description: description,
    rating: 6.7,
    duration: 148,
  ),
  Movie(
    poster: 'assets/movies/demon slayer.jpg',
    title: 'Demon slayer',
    genre: 'Action',
    description: description,
    rating: 8.9,
    duration: 140,
  ),
  Movie(
    poster: 'assets/movies/shadow.jpg',
    title: 'Eminence In Shadow',
    genre: 'Action',
    description: description,
    rating: 8.9,
    duration: 140,
  ),
  Movie(
    poster: 'assets/movies/arcane.jpg',
    title: 'Arcane ',
    genre: 'Drama',
    description: description,
    rating: 9.0,
    duration: 120,
  ),
  Movie(
    poster: 'assets/movies/akame ga kill.jpg',
    title: 'Akame Ga Kill',
    genre: "Comedy",
    description: description,
    rating: 8.3,
    duration: 110,
  ),
  Movie(
    poster: 'assets/movies/dune2.jpg',
    title: 'Dune 2',
    genre: "Magic,",
    description: description,
    rating: 8.5,
    duration: 168,
  ),
  Movie(
    poster: 'assets/movies/furiosa.jpg',
    title: 'Furiosa: A Mad Max Saga',
    genre: "Action,",
    description: description,
    rating: 7.5,
    duration: 148,
  ),
  Movie(
    poster: 'assets/movies/frieren.jpg',
    title: 'Frieren',
    genre: 'Action',
    description: description,
    rating: 8.0,
    duration: 130,
  ),
  Movie(
    poster: 'assets/movies/attack on titan.jpg',
    title: 'Attack On Titans',
    genre: 'Action',
    description: description,
    rating: 8.9,
    duration: 140,
  ),
];

const String description =
    "As the world fell, young Furiosa is snatched from the Green Place of Many Mothers and falls into the hands of a great Biker Horde led by the Warlord Dementus. Sweeping through the Wasteland they come across the Citadel presided over by The Immortan Joe. While the two Tyrants war for dominance, Furiosa must survive many trials as she puts together the means to find her way home.";
