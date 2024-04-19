import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friday_nite_movies/src/features/movies/data/providers/movies_repository_provider.dart';
import 'package:friday_nite_movies/src/features/movies/presentation/movie_list_tile.dart';
import 'package:friday_nite_movies/src/features/movies/presentation/movies_search_bar.dart';
import 'package:friday_nite_movies/src/features/movies/presentation/notifier_provider/movies_search_query_notifier.dart';

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
          Expanded(
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
                  fetchMoviesProvider(queryData: (page: page, query: "")),
                );
                return fetchResponse.when(
                    data: (data) {
                      log('index: $index, page: $page, indexInPage: $indexInPage');
                      // This condition only happens if a null itemCount is given
                      if (indexInPage >= data.results.length) {
                        return null;
                      }
                      return MovieListTile(
                        movie: data.results[indexInPage],
                        debugIndex: index,
                      );
                    },
                    error: (err, stack) => indexInPage == 0
                        ? Text(" error => ${stack.toString()}")
                        : SizedBox.shrink(),
                    loading: () => CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
