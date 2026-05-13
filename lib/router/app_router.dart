import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ui/login_screen.dart';
import '../ui/home_screen.dart';
import '../ui/detail_screen.dart';
import '../ui/map_screen.dart';
import '../providers/auth_provider.dart';
import '../database/app_database.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final isLoggedIn = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isGoingToLogin = state.matchedLocation == '/login';

      if (!isLoggedIn && !isGoingToLogin) return '/login';
      if (isLoggedIn && isGoingToLogin) return '/home';

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/details',
        builder: (context, state) {
          final library = state.extra;
          return DetailsScreen(library: library);
        },
      ),
      GoRoute(
        path: '/map',
        builder: (context, state) => MapScreen(),
      ),
    ],
  );
});