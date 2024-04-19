import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friday_nite_movies/env/env.dart';
import 'package:friday_nite_movies/src/features/movies/data/movies_abstract_repository.dart';
import 'package:friday_nite_movies/src/features/movies/data/movies_repository.dart';
import 'package:friday_nite_movies/src/utils/extensions/cancel_token_ref.dart';
import 'package:friday_nite_movies/src/utils/network/providers/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/tmdb_movie.dart';
import '../../domain/tmdb_movies_response.dart';

part 'movies_repository_provider.g.dart';

@riverpod
MoviesRepository moviesRepository(MoviesRepositoryRef ref) =>
    MoviesRepository(client: ref.watch(dioProvider), apiKey: Env.tmdbApiKey);

/// using provider to fetch a movies by Id
@riverpod
Future<TMDBMovie> movie(MovieRef ref, {required int movieId}) {
  final CancelToken cancelToken = ref.cancelToken();
  return ref
      .watch(moviesRepositoryProvider)
      .movie(movieId: movieId, cancelToken: cancelToken);
}

/// provider to fetch paginated movies data
@riverpod
Future<TMDBMoviesResponse> fetchMovies(FetchMoviesRef ref,
    {required MoviesQueryData queryData}) async {
  final moviesRepo = ref.watch(moviesRepositoryProvider);
  final CancelToken cancelToken = ref.cancelToken();
  // when a page is no-longer used, keep it in the cache
  final KeepAliveLink link = ref.keepAlive();
  // timer to be used by callbacks below
  Timer? timer;
  //when the provider is destroyed, cancel the timer
  ref.onDispose(() {
    timer?.cancel();
  });
  // When the last listener is removed, start a timer to dispose the cached data
  ref.onCancel(() {
    // start a 30 second timer
    timer = Timer(const Duration(seconds: 30), () {
      //dispose cache data after 30 secs
      link.close();
    });
  });
  // If the provider is listened again after it was paused, cancel the timer
  ref.onResume(() {
    timer?.cancel();
  });

  if (queryData.query.isEmpty) {
    // use non-search endpoint
    return moviesRepo.nowPlayingMovies(
        page: queryData.page, cancelToken: cancelToken);
  } else {
    return moviesRepo.searchMovies(
        queryData: queryData, cancelToken: cancelToken);
  }
}
