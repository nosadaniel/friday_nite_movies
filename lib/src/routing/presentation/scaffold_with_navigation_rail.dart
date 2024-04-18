import 'package:flutter/material.dart';
import 'package:friday_nite_movies/src/localization/string_hardcoded.dart';

class ScaffoldWithNavigationRail extends StatelessWidget {
  const ScaffoldWithNavigationRail(
      {required this.body,
      required this.currentIndex,
      required this.onDestinationSelected,
      super.key});
  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            destinations: [
              NavigationRailDestination(
                icon: const Icon(Icons.search_outlined),
                selectedIcon: const Icon(Icons.search),
                label: Text('Search'.hardcoded),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.favorite_outline),
                selectedIcon: const Icon(Icons.favorite),
                label: Text('Favorite'.hardcoded),
              ),
            ],
            selectedIndex: currentIndex,
            onDestinationSelected: onDestinationSelected,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: body)
        ],
      ),
    );
  }
}
