import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../helpers_providers/movie_poster_size.dart';
import '../../domain/tmdb_poster.dart';

class MovieListTileShimmer extends ConsumerWidget {
  const MovieListTileShimmer({this.posterSize, super.key});
  final PosterSize? posterSize;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageSize = ref.read(getImageSizeProvider(size: posterSize));

    return Shimmer.fromColors(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        child: Row(
          children: [
            Container(
              width: 90 * (imageSize.width / imageSize.height),
              height: 90,
              color: Colors.black,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 20.0,
                    color: Colors.black,
                    margin: const EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                    width: 100,
                    height: 20,
                    color: Colors.black,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      baseColor: Colors.black26,
      highlightColor: Colors.black12,
    );
  }
}
