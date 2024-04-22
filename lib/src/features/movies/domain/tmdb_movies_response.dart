// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:friday_nite_movies/src/features/movies/domain/tmdb_movie.dart';

part 'tmdb_movies_response.freezed.dart';
part 'tmdb_movies_response.g.dart';

@freezed
class TMDBMoviesResponse with _$TMDBMoviesResponse {
  const factory TMDBMoviesResponse({
    required int page,
    required List<TMDBMovie> results,
    @JsonKey(name: 'total_results') required int totalResults,
    @JsonKey(name: 'total_pages') required int totalPages,
    @Default([]) List<String> errors,
  }) = _TMDBMoviesResponse;

  factory TMDBMoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$TMDBMoviesResponseFromJson(json);
}

extension TMDBMoviesResponseX on TMDBMoviesResponse {
  bool hasResults() => results.isNotEmpty;
  bool hasErrors() => errors.isNotEmpty;
  bool get isEmpty => !hasResults();
}
