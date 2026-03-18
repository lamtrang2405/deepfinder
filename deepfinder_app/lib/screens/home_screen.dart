import 'package:flutter/material.dart';

import '../app/app_state_scope.dart';
import '../app/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DeepFinder'),
      ),
      drawer: const _SecretDrawer(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
          children: [
            if (!appState.isPro) ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cs.tertiaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lock, color: cs.onTertiaryContainer),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'AI features are locked. Unlock Pro to enable summaries.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: cs.onTertiaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    FilledButton(
                      onPressed: () => Navigator.of(context).pushNamed(Routes.paywall),
                      child: const Text('Unlock'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            _SearchCard(
              onTapSearch: () => Navigator.of(context).pushNamed(Routes.input),
              onTapHistory: () => Navigator.of(context).pushNamed(Routes.history),
            ),
            const SizedBox(height: 14),
            Text(
              'Home',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            _ActionTile(
              icon: Icons.search,
              title: 'Search bar',
              subtitle: 'Start a new search',
              onTap: () => Navigator.of(context).pushNamed(Routes.input),
            ),
            _ActionTile(
              icon: Icons.history,
              title: 'History Search',
              subtitle: 'Review previous searches',
              onTap: () => Navigator.of(context).pushNamed(Routes.history),
            ),
            _ActionTile(
              icon: Icons.public,
              title: 'Europe data demo',
              subtitle: 'Flow: select country → paywall gate',
              onTap: () => Navigator.of(context).pushNamed(Routes.europeDemo),
            ),
            _ActionTile(
              icon: Icons.workspace_premium,
              title: 'CTA Pro',
              subtitle: appState.isPro ? 'You are Pro' : 'Unlock premium features',
              onTap: () => Navigator.of(context).pushNamed(Routes.paywall),
              trailing: appState.isPro
                  ? Icon(Icons.verified, color: cs.primary)
                  : Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 18),
            Text(
              'Tip: open the drawer for “Secret sidebar”.',
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

class _SearchCard extends StatelessWidget {
  const _SearchCard({
    required this.onTapSearch,
    required this.onTapHistory,
  });

  final VoidCallback onTapSearch;
  final VoidCallback onTapHistory;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            cs.primaryContainer,
            cs.secondaryContainer.withAlpha(166),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What do you want to find?',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: cs.onPrimaryContainer,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Ask a question, pick a style, and get a clean result card.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: cs.onPrimaryContainer.withAlpha(217),
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: onTapSearch,
                  icon: const Icon(Icons.search),
                  label: const Text('Search'),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: onTapHistory,
                icon: const Icon(Icons.history),
                label: const Text('History'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;

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
              trailing ?? Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecretDrawer extends StatelessWidget {
  const _SecretDrawer();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Secret sidebar',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: cs.onPrimaryContainer,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Quick actions + hidden settings.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: cs.onPrimaryContainer.withAlpha(217),
                        ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Secret settings'),
              subtitle: const Text('Toggle Pro, clear history'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(Routes.secret);
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Search'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(Routes.input);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('History'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(Routes.history);
              },
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'In your diagram: “click Secret Sidebar” → “Secret Sidebar screen”.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

