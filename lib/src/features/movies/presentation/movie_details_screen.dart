import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetailsScreen extends ConsumerWidget {
  const MovieDetailsScreen({required this.id, super.key});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text("Detailed movies coming soon"),
    );
  }
}
