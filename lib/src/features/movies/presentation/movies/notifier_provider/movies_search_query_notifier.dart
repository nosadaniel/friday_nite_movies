import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movies_search_query_notifier.g.dart';

/// A notifier class to keep track of search query with debouncing
@riverpod
class MoviesSearchQueryNotifier extends _$MoviesSearchQueryNotifier {
  /// to debounce the input queries
  final StreamController<String> _searchQueryController =
      StreamController<String>.broadcast();
  Timer? _debouceTimer;
  late final StreamSubscription<String> _streamSubscription;
  @override
  String build() {
    // listen to the stream of input queries
    _streamSubscription = _searchQueryController.stream.listen((query) {
      //cancel existing timer if any
      _debouceTimer?.cancel();
      //set a new timer for 0.5secs to debounce the query
      _debouceTimer = Timer(const Duration(milliseconds: 500), () {
        _updateState(query);
      });
    });
    //
    ref.onDispose(() {
      _searchQueryController.close();
      _streamSubscription.cancel();
      _debouceTimer?.cancel();
    });
    //by default, return an empty query
    return "";
  }

  void _updateState(String query) {
    // only update the state once the query has been debounced
    state = query;
  }

  void setQuery(String query) {
    _searchQueryController.sink.add(query);
  }
}
