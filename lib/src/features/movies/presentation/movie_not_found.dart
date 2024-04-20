import 'package:flutter/material.dart';
import 'package:friday_nite_movies/src/localization/string_hardcoded.dart';

class MovieNotFound extends StatelessWidget {
  const MovieNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        child: Center(
          child: Text(
            "No movie found!".hardcoded,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
    );
  }
}
