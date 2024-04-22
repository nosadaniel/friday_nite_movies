enum PosterSize {
  w92,
  w154,
  w185,
  w342,
  w500,
  w780,
  original,
}

class TMDBPoster {
  static String tmdbBaseImageUrl = "http://image.tmdb.org/t/p/";

  static String imageUrl(String path, PosterSize size) {
    final s = "$tmdbBaseImageUrl${size.name}$path";
    //log("poster pather => $s");
    return s;
  }
}
