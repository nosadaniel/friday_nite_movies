import 'package:flutter_test/flutter_test.dart';
import 'package:friday_nite_movies/src/features/movies/data/movies_repository.dart';
import 'package:friday_nite_movies/src/features/movies/domain/tmdb_movie.dart';
import 'package:friday_nite_movies/src/features/movies/domain/tmdb_movies_response.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tmdb_object_unit_test.mocks.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([MockSpec<MoviesRepository>()])
void main() {
  final MockMoviesRepository mockMoviesRepository = MockMoviesRepository();

  test(" TMDBMovie object test ", () async {
    when(mockMoviesRepository.movie(movieId: 1112)).thenAnswer((_) async =>
        await TMDBMovie(id: 11, title: "wf", overview: "overview"));
    expect(await mockMoviesRepository.movie(movieId: 1112), isA<TMDBMovie>());
  });
  test("TMDBMoviesResponse object", () async {
    when(mockMoviesRepository.nowPlayingMovies(page: 1)).thenAnswer((_) async =>
        TMDBMoviesResponse(
            page: 1, results: <TMDBMovie>[], totalResults: 1, totalPages: 1));
    expect(await mockMoviesRepository.nowPlayingMovies(page: 1),
        isA<TMDBMoviesResponse>());
  });
}
