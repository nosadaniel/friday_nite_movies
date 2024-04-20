import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/movies/domain/tmdb_poster.dart';

part 'movie_poster_size.g.dart';

final Map<PosterSize, double> _imageWidth = {
  PosterSize.w92: 92.0,
  PosterSize.w154: 154.0,
  PosterSize.w185: 185.0,
  PosterSize.w342: 342.0,
  PosterSize.w500: 500.0,
  PosterSize.w780: 780.0
};

final Map<PosterSize, double> _imageHeight = {
  PosterSize.w92: 100.0,
  PosterSize.w154: 231.0,
  PosterSize.w185: 300.0,
  PosterSize.w342: 600.0,
  PosterSize.w500: 1000.0,
  PosterSize.w780: 1500.0
};

@riverpod
({double width, double height}) getImageSize(GetImageSizeRef ref,
    {PosterSize? size}) {
  final double width = _imageWidth[size ?? PosterSize.w154] ?? 154.0;
  final double height = _imageHeight[size ?? PosterSize.w154] ?? 231.0;
  return (width: width, height: height);
}
