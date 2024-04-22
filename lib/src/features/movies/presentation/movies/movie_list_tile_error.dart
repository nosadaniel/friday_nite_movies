import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friday_nite_movies/src/features/movies/data/providers/movies_repository_provider.dart';

class MovieListTileError extends ConsumerWidget {
  const MovieListTileError(
      {required this.query,
      required this.page,
      required this.indexInPage,
      required this.isLoading,
      required this.error,
      super.key});

  final String query;
  final int page;
  final int indexInPage;
  final bool isLoading;
  final String error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Only show error on the first item of the page

    return indexInPage == 0
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(child: Text(error)),
                ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            // invalidate the provider for the error page
                            ref.invalidate(
                              fetchMoviesProvider(
                                  queryData: (page: page, query: query)),
                            );
                          },
                    child: const Icon(Icons.refresh_rounded))
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
