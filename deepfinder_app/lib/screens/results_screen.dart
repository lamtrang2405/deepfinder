import 'package:flutter/material.dart';

import '../app/app_state_scope.dart';
import '../app/routes.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final cs = Theme.of(context).colorScheme;
    final args = (ModalRoute.of(context)?.settings.arguments as Map?) ?? const {};

    final query = (args['query'] as String?)?.trim().isNotEmpty == true ? args['query'] as String : 'Your query';
    final topic = (args['topic'] as String?) ?? 'News';
    final tone = (args['tone'] as String?) ?? 'Concise';
    final includeSources = (args['includeSources'] as bool?) ?? true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        actions: [
          IconButton(
            tooltip: 'Search again',
            onPressed: () => Navigator.of(context).pushNamed(Routes.input),
            icon: const Icon(Icons.search),
          ),
        ],
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
                    query,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _Chip(text: 'Topic: $topic'),
                      _Chip(text: 'Style: $tone'),
                      _Chip(text: appState.isPro ? 'Pro: On' : 'Pro: Off'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
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
                        'AI summary is locked. Unlock to see smarter highlights.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: cs.onTertiaryContainer,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    FilledButton(
                      onPressed: () => Navigator.of(context).pushNamed(Routes.paywall),
                      child: const Text('Unlock AI'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            Text(
              appState.isPro ? 'AI summary' : 'Preview',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            _ResultCard(
              title: 'Summary',
              body: appState.isPro
                  ? _proSummary(query: query, topic: topic, tone: tone)
                  : 'Upgrade to Pro to generate a complete summary with key points and sources.',
            ),
            const SizedBox(height: 12),
            Text(
              'Related results',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            for (final item in _relatedItems(topic))
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _ResultCard(
                  title: item.$1,
                  body: item.$2,
                  footer: includeSources ? _sourcesRow() : null,
                ),
              ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pushNamed(Routes.history),
              icon: const Icon(Icons.history),
              label: const Text('View History'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.title, required this.body, this.footer});

  final String title;
  final String body;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withAlpha(115),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(body, style: Theme.of(context).textTheme.bodyMedium),
          if (footer != null) ...[
            const SizedBox(height: 10),
            footer!,
          ],
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

Widget _sourcesRow() {
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: const [
      Chip(label: Text('Reuters')),
      Chip(label: Text('EU Parliament')),
      Chip(label: Text('OpenAI blog')),
    ],
  );
}

String _proSummary({required String query, required String topic, required String tone}) {
  final style = switch (tone) {
    'Deep dive' => 'a deeper explanation',
    'Bullet points' => 'bullet-point takeaways',
    _ => 'a concise answer',
  };
  return 'Here’s $style for “$query” in the $topic context. This is placeholder content you can later replace with your AI/backend output.';
}

List<(String, String)> _relatedItems(String topic) {
  switch (topic) {
    case 'Crypto':
      return [
        ('Market pulse', 'Latest price moves and on-chain signals (placeholder).'),
        ('Regulatory watch', 'Policy updates impacting exchanges (placeholder).'),
      ];
    case 'Tools':
      return [
        ('Best tooling', 'Suggested tools and alternatives (placeholder).'),
        ('Setup guide', 'Quick steps and gotchas (placeholder).'),
      ];
    default:
      return [
        ('What happened?', 'A quick explanation of the key development (placeholder).'),
        ('Why it matters', 'Impact on users, markets, and policy (placeholder).'),
      ];
  }
}

