import 'dart:async';

import 'package:flutter/material.dart';

import '../app/app_state_scope.dart';
import '../app/routes.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1300), () {
      if (!mounted) return;
      final args = (ModalRoute.of(context)?.settings.arguments as Map?) ?? const {};
      Navigator.of(context).pushReplacementNamed(Routes.results, arguments: args);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final args = (ModalRoute.of(context)?.settings.arguments as Map?) ?? const {};
    final query = (args['query'] as String?)?.trim() ?? '';

    if (query.isNotEmpty) {
      AppStateScope.of(context).addToHistory(query);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 56,
                  height: 56,
                  child: CircularProgressIndicator(strokeWidth: 4),
                ),
                const SizedBox(height: 16),
                Text(
                  'Searching…',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  query.isEmpty ? 'Fetching results' : '“$query”',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

