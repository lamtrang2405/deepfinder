import 'package:flutter/material.dart';

import '../app/routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_page >= 2) {
      Navigator.of(context).pushReplacementNamed(Routes.paywall);
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final pages = [
      _OnboardPage(
        icon: Icons.travel_explore,
        title: 'Search with clarity',
        subtitle: 'Ask a question and DeepFinder will summarize what matters.',
      ),
      _OnboardPage(
        icon: Icons.tune,
        title: 'Adjust your intent',
        subtitle: 'Pick topic + style and get answers that match your needs.',
      ),
      _OnboardPage(
        icon: Icons.lock_open,
        title: 'Unlock AI features',
        subtitle: 'Go Pro for faster answers, more sources, and smarter summaries.',
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed(Routes.paywall),
                    child: const Text('Skip'),
                  ),
                  const Spacer(),
                  Text(
                    '${_page + 1}/3',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (p) => setState(() => _page = p),
                children: pages,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: _next,
                      child: Text(_page >= 2 ? 'Continue' : 'Next'),
                    ),
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

class _OnboardPage extends StatelessWidget {
  const _OnboardPage({
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
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        children: [
          const Spacer(),
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Icon(icon, size: 58, color: cs.onPrimaryContainer),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

