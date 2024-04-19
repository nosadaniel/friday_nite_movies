import 'package:dio/dio.dart';
import 'package:friday_nite_movies/src/features/movies/data/movies_abstract_repository.dart';
import 'package:friday_nite_movies/src/features/movies/domain/tmdb_movie.dart';
import 'package:friday_nite_movies/src/features/movies/domain/tmdb_movies_response.dart';
import 'package:friday_nite_movies/src/utils/constants.dart';

class MoviesRepository implements MoviesAbstractRepository {
  const MoviesRepository({required this.client, required this.apiKey});
  final Dio client;
  final String apiKey;
  @override
  Future<TMDBMovie> movie(
      {required int movieId, CancelToken? cancelToken}) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: TMDB_HOST,
      path: '$TMDB_MOVIE_VERSION/$movieId',
      queryParameters: {'api_key': apiKey},
    );
    final String url = uri.toString();
    final Response response = await client.get(url, cancelToken: cancelToken);

    return TMDBMovie.fromJson(response.data);
  }

  @override
  Future<TMDBMoviesResponse> nowPlayingMovies(
      {required int page, CancelToken? cancelToken}) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: TMDB_HOST,
      path: '$TMDB_MOVIE_VERSION/now_playing',
      queryParameters: {'api_key': apiKey, 'page': "$page"},
    );
    final String url = uri.toString();
    final Response response = await client.get(url, cancelToken: cancelToken);
    //log("data => ${response.data}");
    return TMDBMoviesResponse.fromJson(response.data);
  }

  @override
  Future<TMDBMoviesResponse> searchMovies(
      {required MoviesQueryData queryData, CancelToken? cancelToken}) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: TMDB_HOST,
      path: TMDB_SEARCH_VERSION,
      queryParameters: {
        'api_key': apiKey,
        'page': "${queryData.page}",
        'query': queryData.query
      },
    );
    final String url = uri.toString();
    final Response response = await client.get(url, cancelToken: cancelToken);
    return TMDBMoviesResponse.fromJson(response.data);
  }
}
