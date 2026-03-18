import 'package:flutter/material.dart';

import '../app/app_state_scope.dart';

class SecretScreen extends StatelessWidget {
  const SecretScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Secret Sidebar'),
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
                    'Debug toggles',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    value: appState.isPro,
                    onChanged: appState.setPro,
                    title: const Text('Pro mode'),
                    subtitle: const Text('Simulate “Unlock AI”'),
                  ),
                  const Divider(height: 20),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.delete_outline),
                    title: const Text('Clear history'),
                    subtitle: Text(
                      'Remove all saved searches',
                      style: TextStyle(color: cs.onSurfaceVariant),
                    ),
                    onTap: () => appState.clearHistory(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'This screen maps to the diagram’s “Secret Sidebar screen”.',
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

