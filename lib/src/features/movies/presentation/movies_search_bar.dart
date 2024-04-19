import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friday_nite_movies/src/features/movies/presentation/notifier_provider/movies_search_query_notifier.dart';
import 'package:friday_nite_movies/src/localization/string_hardcoded.dart';

class MoviesSearchBar extends ConsumerStatefulWidget {
  const MoviesSearchBar({super.key});

  @override
  ConsumerState createState() => _MoviesSearchBarState();
}

class _MoviesSearchBarState extends ConsumerState<MoviesSearchBar> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        //borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _textController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  hintText: 'Search movies'.hardcoded,
                  hintStyle: TextStyle(color: Colors.grey.shade900),
                ),
                onEditingComplete: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onChanged: (value) {
                  ref
                      .read(moviesSearchQueryNotifierProvider.notifier)
                      .setQuery(value);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
