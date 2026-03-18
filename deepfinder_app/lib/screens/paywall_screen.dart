import 'package:flutter/material.dart';

import '../app/app_state_scope.dart';
import '../app/routes.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Go Pro'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed(Routes.home),
            child: const Text('Not now'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Icon(Icons.workspace_premium, color: cs.onPrimaryContainer),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Unlock AI summaries and premium results.',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: cs.onPrimaryContainer,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _FeatureTile(
              icon: Icons.auto_awesome,
              title: 'AI summary',
              subtitle: 'Get a concise answer + key sources.',
            ),
            _FeatureTile(
              icon: Icons.speed,
              title: 'Faster results',
              subtitle: 'Skip waits and get premium ranking.',
            ),
            _FeatureTile(
              icon: Icons.history,
              title: 'Unlimited history',
              subtitle: 'Keep more searches at your fingertips.',
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () {
                appState.setPro(true);
                Navigator.of(context).pushReplacementNamed(Routes.home);
              },
              child: const Text('Unlock AI (Pro)'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                appState.setPro(false);
                Navigator.of(context).pushReplacementNamed(Routes.home);
              },
              child: const Text('Continue free'),
            ),
            const SizedBox(height: 14),
            Text(
              'This is a UI flow prototype — payments are not integrated.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest.withAlpha(115),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: cs.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

