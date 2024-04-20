import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friday_nite_movies/src/features/favorites/presentation/favorites_screen.dart';
import 'package:friday_nite_movies/src/features/movies/domain/tmdb_movie.dart';
import 'package:friday_nite_movies/src/features/movies/presentation/Movies_search_screen.dart';
import 'package:friday_nite_movies/src/features/movies/presentation/movie_details_screen.dart';
import 'package:friday_nite_movies/src/routing/scaffold_with_nested_navigation.dart';
import 'package:go_router/go_router.dart';

enum AppRoute { movies, movie, favorites }

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _searchNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'search');
final _favoritesNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'favorites');

final goRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: '/movies',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      //stateful navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNestedNavigation(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _searchNavigatorKey,
            routes: [
              GoRoute(
                  path: '/${AppRoute.movies.name}',
                  name: AppRoute.movies.name,
                  pageBuilder: (context, state) => NoTransitionPage(
                      child: const MoviesSearchScreen(), key: state.pageKey),
                  routes: [
                    GoRoute(
                      path: ":id",
                      name: AppRoute.movie.name,
                      pageBuilder: (context, state) {
                        final String id = state.pathParameters['id'] as String;
                        final TMDBMovie? movie = state.extra is TMDBMovie
                            ? state.extra as TMDBMovie
                            : null;
                        return MaterialPage(
                          key: state.pageKey,
                          child: MovieDetailsScreen(id: id, tmdbMovie: movie),
                        );
                      },
                    ),
                  ]),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _favoritesNavigatorKey,
            routes: [
              GoRoute(
                path: "/${AppRoute.favorites.name}",
                name: AppRoute.favorites.name,
                pageBuilder: (context, state) => NoTransitionPage(
                    child: const FavoritesScreen(), key: state.pageKey),
              )
            ],
          ),
        ],
      ),
    ],
  ),
);
