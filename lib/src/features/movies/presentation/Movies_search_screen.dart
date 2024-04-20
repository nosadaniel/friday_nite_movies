import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friday_nite_movies/src/features/movies/data/providers/movies_repository_provider.dart';
import 'package:friday_nite_movies/src/features/movies/domain/tmdb_movie.dart';
import 'package:friday_nite_movies/src/features/movies/presentation/movie_list_tile.dart';
import 'package:friday_nite_movies/src/features/movies/presentation/movie_list_tile_error.dart';
import 'package:friday_nite_movies/src/features/movies/presentation/movie_list_tile_shimmer.dart';
import 'package:friday_nite_movies/src/features/movies/presentation/movie_not_found.dart';
import 'package:friday_nite_movies/src/features/movies/presentation/movies_search_bar.dart';
import 'package:friday_nite_movies/src/features/movies/presentation/notifier_provider/movies_search_query_notifier.dart';
import 'package:friday_nite_movies/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class MoviesSearchScreen extends ConsumerWidget {
  const MoviesSearchScreen({super.key});
  static const pageSize = 20;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //get the query, empty by default
    final String query = ref.watch(moviesSearchQueryNotifierProvider);
    //get the first page, so we can retrieve the total number of results
    final fetchMovies =
        ref.watch(fetchMoviesProvider(queryData: (page: 1, query: query)));
    final int? totalResults = fetchMovies.valueOrNull?.totalResults;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Friday Nite Movies"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const MoviesSearchBar(),
          totalResults == 0 ? MovieNotFound() : SizedBox.shrink(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await onRefresh(ref: ref, query: query);
              },
              child: ListView.builder(
                // use a different key for each query, ensuring the scroll
                // position is reset when the query and results change
                key: ValueKey(query),
                // * pass the itemCount explicitly to prevent unnecessary renders
                // * during overscroll
                itemCount: totalResults,
                itemBuilder: (context, index) {
                  //get the page integer value of the division
                  final page = index ~/ pageSize + 1;
                  //get the reminder value
                  final indexInPage = index % pageSize;
                  // use the fact that this is an infinite list to fetch a new page
                  // as soon as the index exceeds the page size
                  // Note that ref.watch is called for up to pageSize items
                  // with the same page and query arguments (but this is ok since data is cached)
                  final fetchResponse = ref.watch(
                    fetchMoviesProvider(queryData: (page: page, query: query)),
                  );
                  return fetchResponse.when(
                      data: (data) {
                        log('index: $index, page: $page, indexInPage: $indexInPage');
                        // This condition only happens if a null itemCount is given
                        // also when query does return empty result
                        if (indexInPage >= data.results.length) {
                          return null;
                        }
                        final TMDBMovie movie = data.results[indexInPage];
                        return MovieListTile(
                          movie: movie,
                          debugIndex: index,
                          onPressed: () => context.goNamed(AppRoute.movie.name,
                              pathParameters: {'id': movie.id.toString()},
                              extra: movie),
                        );
                      },
                      error: (err, stack) {
                        log("error => $err");
                        return MovieListTileError(
                          query: query,
                          page: page,
                          indexInPage: indexInPage,
                          error: err.toString(),
                          isLoading: fetchResponse.isLoading,
                        );
                      },
                      loading: () => MovieListTileShimmer());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //callback on pull
  Future<void> onRefresh(
      {required WidgetRef ref, required String query, int? page}) async {
    // dispose all the pages previously fetched. Next read will refresh them
    ref.invalidate(fetchMoviesProvider);
    // keep showing the progress indicator until the first page is fetched
    try {
      await ref.read(
          fetchMoviesProvider(queryData: (page: page ?? 1, query: query))
              .future);
    } catch (e) {
      // fail silently as the provider error state is handled inside the ListView
    }
  }
}
