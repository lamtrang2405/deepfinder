import 'package:flutter/material.dart';

import '../app/routes.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _queryController = TextEditingController();

  String _topic = 'News';
  String _tone = 'Concise';
  bool _includeSources = true;

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final query = _queryController.text.trim();
    Navigator.of(context).pushNamed(
      Routes.loading,
      arguments: {
        'query': query,
        'topic': _topic,
        'tone': _tone,
        'includeSources': _includeSources,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
            children: [
              Text(
                'Type your input',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _queryController,
                textInputAction: TextInputAction.search,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'e.g. What’s the latest on EU AI Act updates?',
                  prefixIcon: Icon(Icons.search),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter a query' : null,
                onFieldSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 12),
              _SectionLabel(text: 'Topic'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final t in const ['News', 'Crypto', 'Tools', 'Professional', 'Background'])
                    ChoiceChip(
                      label: Text(t),
                      selected: _topic == t,
                      onSelected: (_) => setState(() => _topic = t),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              _SectionLabel(text: 'Answer style'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final t in const ['Concise', 'Deep dive', 'Bullet points'])
                    ChoiceChip(
                      label: Text(t),
                      selected: _tone == t,
                      onSelected: (_) => setState(() => _tone = t),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                value: _includeSources,
                onChanged: (v) => setState(() => _includeSources = v),
                title: const Text('Include sources'),
                subtitle: Text(
                  'Adds source-style chips in results',
                  style: TextStyle(color: cs.onSurfaceVariant),
                ),
              ),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: _submit,
                child: const Text('Search'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: cs.onSurfaceVariant,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
    );
  }
}

