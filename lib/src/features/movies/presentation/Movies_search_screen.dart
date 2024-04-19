import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friday_nite_movies/src/features/movies/data/movies_repository_provider.dart';

class MoviesSearchScreen extends ConsumerWidget {
  const MoviesSearchScreen({super.key});
  static const pageSize = 20;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemBuilder: (context, index) {
        //get the page integer value of the division
        final page = index ~/ pageSize + 1;
        //get the reminder value
        final indexInPage = index % page;
        final fetchResponse = ref.watch(
          fetchMoviesProvider(queryData: (page: page, query: "")),
        );
        return fetchResponse.when(
            data: (data) {
              // This condition only happens if a null itemCount is given
              if (indexInPage >= data.results.length) {
                return null;
              }
              return Text(data.results[indexInPage].overview);
            },
            error: (err, stack) {
              log("error => $err");
              log("err stack => $stack");
              return Text(" error => ${stack.toString()}");
            },
            loading: () => CircularProgressIndicator());
      },
    );
  }
}
