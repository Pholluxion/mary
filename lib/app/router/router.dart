import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mary/features/login/presentation/pages/pages.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/notification_page.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: "/login",
  errorBuilder: (context, state) => const Scaffold(),
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
      redirect: (context, state) {
        if (FirebaseAuth.instance.currentUser != null) {
          return '/';
        } else {
          return '/login';
        }
      },
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      redirect: (context, state) {
        if (FirebaseAuth.instance.currentUser != null) {
          return '/';
        } else {
          return '/login';
        }
      },
      routes: [
        GoRoute(
          path: 'notify',
          builder: (context, state) => const NotificationPage(),
        )
      ],
    ),
  ],
);
