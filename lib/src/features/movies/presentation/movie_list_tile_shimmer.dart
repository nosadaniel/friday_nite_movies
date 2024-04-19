import 'package:flutter/material.dart';
import 'package:friday_nite_movies/src/common_widgets/movie_poster.dart';
import 'package:friday_nite_movies/src/features/movies/presentation/movie_list_tile.dart';
import 'package:shimmer/shimmer.dart';

class MovieListTileShimmer extends StatelessWidget {
  const MovieListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        child: Row(
          children: [
            Container(
              width: MovieListTile.posterHeight *
                  (MoviePoster.width / MoviePoster.height),
              height: MovieListTile.posterHeight,
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
