import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:friday_nite_movies/src/common_widgets/movie_poster.dart';
import 'package:friday_nite_movies/src/features/movies/domain/tmdb_movie.dart';

import '../../../common_widgets/top_gradient.dart';

class MovieListTile extends StatelessWidget {
  const MovieListTile(
      {required this.movie, this.debugIndex, this.onPressed, super.key});
  final TMDBMovie movie;
  final int? debugIndex;
  final VoidCallback? onPressed;
  static const posterHeight = 150.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: onPressed,
          child: Row(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width:
                        posterHeight * (MoviePoster.width / MoviePoster.height),
                    height: posterHeight,
                    child: MoviePoster(imagePath: movie.posterPath),
                  ),
                  if (debugIndex != null) ...[
                    const Positioned.fill(child: TopGradient()),
                    Positioned(child: Text('$debugIndex'))
                  ]
                ],
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title),
                    if (movie.releaseDate != null) ...[
                      const SizedBox(height: 5),
                      Text('Released: ${movie.releaseDate}'),
                    ]
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
