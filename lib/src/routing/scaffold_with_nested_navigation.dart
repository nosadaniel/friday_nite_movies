import 'package:flutter/material.dart';
import 'package:friday_nite_movies/src/routing/presentation/scaffold_with_navigation_bar.dart';
import 'package:friday_nite_movies/src/routing/presentation/scaffold_with_navigation_rail.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({required this.navigationShell, Key? key})
      : super(
          key: key ?? const ValueKey("ScaffoldWithNestedNavigation"),
        );
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(index,
        // A common pattern when using bottom navigation bars is to support
        // navigating to the initial location when tapping the item that is
        // already active. This example demonstrates how to support this behavior,
        // using the initialLocation parameter of goBranch.
        initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => constraints.maxWidth < 450
          ? ScaffoldWithNavigationBar(
              body: navigationShell,
              currentIndex: navigationShell.currentIndex,
              onDestinationSelected: _goBranch,
            )
          : ScaffoldWithNavigationRail(
              body: navigationShell,
              currentIndex: navigationShell.currentIndex,
              onDestinationSelected: _goBranch,
            ),
    );
  }
}
