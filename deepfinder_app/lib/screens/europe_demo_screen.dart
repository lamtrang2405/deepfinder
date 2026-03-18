import 'package:flutter/material.dart';

import '../app/app_state.dart';
import '../app/app_state_scope.dart';
import '../app/routes.dart';

class EuropeDemoScreen extends StatelessWidget {
  const EuropeDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Europe data demo'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest.withAlpha(115),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Europe data demo screen',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'In your flow: Home → Europe data demo → (locked CTA) Paywall.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _CountryTile(
              country: 'Germany',
              onTap: () => _handleLocked(context, appState, 'Germany'),
            ),
            _CountryTile(
              country: 'France',
              onTap: () => _handleLocked(context, appState, 'France'),
            ),
            _CountryTile(
              country: 'Spain',
              onTap: () => _handleLocked(context, appState, 'Spain'),
            ),
            const SizedBox(height: 12),
            Text(
              appState.isPro ? 'Pro is enabled — country taps go to results.' : 'Pro is disabled — country taps go to paywall.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLocked(BuildContext context, AppState appState, String country) {
    if (!appState.isPro) {
      Navigator.of(context).pushNamed(Routes.paywall);
      return;
    }
    Navigator.of(context).pushNamed(
      Routes.loading,
      arguments: {
        'query': 'Europe demo: $country',
        'topic': 'News',
        'tone': 'Bullet points',
        'includeSources': true,
      },
    );
  }
}

class _CountryTile extends StatelessWidget {
  const _CountryTile({required this.country, required this.onTap});

  final String country;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest.withAlpha(115),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const Icon(Icons.flag_outlined),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  country,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

