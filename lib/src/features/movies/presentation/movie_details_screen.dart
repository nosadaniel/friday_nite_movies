import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friday_nite_movies/src/features/movies/domain/tmdb_movie.dart';

class MovieDetailsScreen extends ConsumerWidget {
  const MovieDetailsScreen({required this.id, this.tmdbMovie, super.key});
  final String id;
  final TMDBMovie? tmdbMovie;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text("${tmdbMovie?.overview}"),
    );
  }
}
