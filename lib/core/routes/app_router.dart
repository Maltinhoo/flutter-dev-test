import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev_test/app_imports.dart';

class GoRouterSystem {
  const GoRouterSystem._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');
  static final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  static BuildContext? get ctx =>
      router.routerDelegate.navigatorKey.currentContext;

  static const String initialRoutePath = LoginPage.route;

  static GoRouter router = GoRouter(
    initialLocation: initialRoutePath,
    debugLogDiagnostics: kDebugMode,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: LoginPage.route,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RecoverySecretPage.route,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return RecoverySecretPage(
            email: args?['email'],
            password: args?['password'],
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: HomePage.route,
        builder: (context, state) => const HomePage(),
      ),
    ],
    errorPageBuilder: (BuildContext context, GoRouterState state) {
      return MaterialPage(
        key: state.pageKey,
        child:
            Scaffold(body: Center(child: CustomText(state.error.toString()))),
      );
    },
  );
}
