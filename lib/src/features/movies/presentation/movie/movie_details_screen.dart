import 'package:flutter/material.dart';
import 'package:friday_nite_movies/src/common_widgets/movie_poster.dart';
import 'package:friday_nite_movies/src/common_widgets/top_gradient.dart';
import 'package:friday_nite_movies/src/features/movies/domain/tmdb_movie.dart';
import 'package:friday_nite_movies/src/features/movies/domain/tmdb_poster.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({required this.id, this.tmdbMovie, super.key});
  final String id;
  final TMDBMovie? tmdbMovie;
  @override
  Widget build(BuildContext context) {
    if (tmdbMovie != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(tmdbMovie!.title),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  MoviePoster(
                    imagePath: tmdbMovie!.posterPath,
                    posterSize: PosterSize.w342,
                  ),
                  Positioned.fill(child: TopGradient())
                ],
              ),
              Divider(),
              RichText(
                text: TextSpan(
                    text: "Reviewed: ",
                    style: Theme.of(context).textTheme.titleSmall,
                    children: [
                      TextSpan(
                          text: "${tmdbMovie!.overview}",
                          style: Theme.of(context).textTheme.bodyLarge)
                    ]),
              )
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
