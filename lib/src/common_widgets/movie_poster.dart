import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friday_nite_movies/src/features/movies/domain/tmdb_poster.dart';
import 'package:friday_nite_movies/src/helpers_providers/movie_poster_size.dart';
import 'package:shimmer/shimmer.dart';

class MoviePoster extends ConsumerWidget {
  const MoviePoster({this.imagePath, this.posterSize, super.key});
  final String? imagePath;
  final PosterSize? posterSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (imagePath != null) {
      final imageSize = ref.read(getImageSizeProvider(size: posterSize));
      return CachedNetworkImage(
        imageUrl:
            TMDBPoster.imageUrl(imagePath!, posterSize ?? PosterSize.w154),
        placeholder: (context, _) => Shimmer.fromColors(
          baseColor: Colors.black26,
          highlightColor: Colors.black12,
          child: Container(
              width: imageSize.width,
              height: imageSize.height,
              color: Colors.black),
        ),
      );
    } else {
      return const Placeholder(
        color: Colors.black54,
      );
    }
  }
}
