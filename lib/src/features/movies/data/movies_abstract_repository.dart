import 'package:dio/dio.dart';

import '../domain/tmdb_movie.dart';
import '../domain/tmdb_movies_response.dart';

/// Metadata used when fetching movies with the paginated search API.
typedef MoviesQueryData = ({String query, int page});

abstract class MoviesAbstractRepository {
  Future<TMDBMoviesResponse> searchMovies(
      {required MoviesQueryData queryData, CancelToken? cancelToken});

  Future<TMDBMoviesResponse> nowPlayingMovies(
      {required int page, CancelToken? cancelToken});

  Future<TMDBMovie> movie({required int movieId, CancelToken? cancelToken});
}
