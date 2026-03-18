import 'package:flutter/material.dart';

import '../screens/history_screen.dart';
import '../screens/home_screen.dart';
import '../screens/input_screen.dart';
import '../screens/loading_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/paywall_screen.dart';
import '../screens/results_screen.dart';
import '../screens/secret_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/europe_demo_screen.dart';
import 'app_state.dart';
import 'app_state_scope.dart';
import 'routes.dart';

class DeepFinderApp extends StatefulWidget {
  const DeepFinderApp({super.key});

  @override
  State<DeepFinderApp> createState() => _DeepFinderAppState();
}

class _DeepFinderAppState extends State<DeepFinderApp> {
  late final AppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = AppState();
  }

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
    );

    return AppStateScope(
      notifier: _appState,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DeepFinder',
        theme: base.copyWith(
          appBarTheme: const AppBarTheme(centerTitle: false),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: base.colorScheme.surfaceContainerHighest.withAlpha(140),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        initialRoute: Routes.splash,
        onGenerateRoute: (settings) {
          final name = settings.name ?? Routes.splash;
          return MaterialPageRoute(
            settings: settings,
            builder: (_) {
              switch (name) {
                case Routes.splash:
                  return const SplashScreen();
                case Routes.onboarding:
                  return const OnboardingScreen();
                case Routes.paywall:
                  return const PaywallScreen();
                case Routes.home:
                  return const HomeScreen();
                case Routes.input:
                  return const InputScreen();
                case Routes.loading:
                  return const LoadingScreen();
                case Routes.results:
                  return const ResultsScreen();
                case Routes.history:
                  return const HistoryScreen();
                case Routes.secret:
                  return const SecretScreen();
                case Routes.europeDemo:
                  return const EuropeDemoScreen();
                default:
                  return const SplashScreen();
              }
            },
          );
        },
      ),
    );
  }
}

