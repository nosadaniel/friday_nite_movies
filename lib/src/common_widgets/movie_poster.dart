import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friday_nite_movies/src/features/movies/domain/tmdb_poster.dart';
import 'package:shimmer/shimmer.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({this.imagePath, super.key});
  final String? imagePath;

  static const width = 154.0;
  static const height = 231.0;

  @override
  Widget build(BuildContext context) {
    return imagePath != null
        ? CachedNetworkImage(
            imageUrl: TMDBPoster.imageUrl(imagePath!, PosterSize.w154),
            placeholder: (context, _) => Shimmer.fromColors(
              baseColor: Colors.black26,
              highlightColor: Colors.black12,
              child:
                  Container(width: width, height: height, color: Colors.black),
            ),
          )
        : const Placeholder(
            color: Colors.black54,
          );
  }
}
