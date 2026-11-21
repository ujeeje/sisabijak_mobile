import 'package:flutter/material.dart';

import '../../../common/constants/colors.dart';

class OrderBody extends StatelessWidget {
  final List<Widget> children;
  const OrderBody({super.key, required this.children});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: ListView(padding: const EdgeInsets.all(20), children: children),
      ),
    ),
  );
}

class OrderPanel extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const OrderPanel({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) => Card(
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(
        color: Theme.of(context).dividerColor.withValues(alpha: .2),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    ),
  );
}

class OrderEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final Widget? action;
  const OrderEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 24),
    child: Column(
      children: [
        CircleAvatar(
          radius: 34,
          backgroundColor: AppColors.primary.withValues(alpha: .08),
          child: Icon(icon, size: 32, color: AppColors.primary),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        if (action != null) ...[const SizedBox(height: 20), action!],
      ],
    ),
  );
}

class OrderNotice extends StatelessWidget {
  final String message;
  const OrderNotice(this.message, {super.key});

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.primary.withValues(alpha: .06),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      message,
      style: const TextStyle(color: AppColors.textSecondary),
    ),
  );
}
