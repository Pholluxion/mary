import 'package:go_router/go_router.dart';
import 'package:mary/features/login/presentation/pages/pages.dart';

import '../../features/home/presentation/pages/home_page.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    )
  ],
);
