import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friday_nite_movies/src/common_widgets/movie_poster.dart';
import 'package:friday_nite_movies/src/features/movies/domain/tmdb_movie.dart';
import 'package:friday_nite_movies/src/helpers_providers/movie_poster_size.dart';

import '../../../../common_widgets/top_gradient.dart';
import '../../domain/tmdb_poster.dart';

class MovieListTile extends ConsumerWidget {
  const MovieListTile(
      {required this.movie,
      this.debugIndex,
      this.onPressed,
      this.posterSize,
      super.key});
  final TMDBMovie movie;
  final int? debugIndex;
  final VoidCallback? onPressed;
  final PosterSize? posterSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageSize = ref.read(getImageSizeProvider(size: posterSize));
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        child: GestureDetector(
          onTap: onPressed,
          child: Row(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 90 * (imageSize.width / imageSize.height),
                    height: 90,
                    child: MoviePoster(
                      imagePath: movie.posterPath,
                    ),
                  ),
                  if (debugIndex != null) ...[
                    const Positioned.fill(child: TopGradient()),
                    Positioned(child: Text('$debugIndex'))
                  ]
                ],
              ),
              SizedBox(width: 8),
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
