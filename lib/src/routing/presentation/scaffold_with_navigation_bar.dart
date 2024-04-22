import 'package:flutter/material.dart';

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar(
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
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            label: 'Search',
            selectedIcon: Icon(Icons.search),
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorite',
            selectedIcon: Icon(Icons.favorite),
          )
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}
