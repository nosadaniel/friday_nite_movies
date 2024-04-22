// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tmdb_movie.freezed.dart';
part 'tmdb_movie.g.dart';

@freezed
class TMDBMovie with _$TMDBMovie {
  const factory TMDBMovie({
    required int id,
    required String title,
    required String overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'release_date') String? releaseDate,
  }) = _TMDBMovie;

  factory TMDBMovie.fromJson(Map<String, Object?> json) =>
      _$TMDBMovieFromJson(json);
}
