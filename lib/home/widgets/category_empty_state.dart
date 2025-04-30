import 'package:flutter/material.dart';
import 'package:textile/home/screens/new_category.dart';
import 'package:textile/modules/shared/widgets/colors.dart';
import 'package:textile/modules/shared/widgets/transitions.dart';

class CategoryEmptyState extends StatelessWidget {
  const CategoryEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_circle_outline,
          size: 48,
          color: AppTheme.currentTheme.colorScheme.tertiary,
        ),
        const SizedBox(height: 16),
        Text(
          'No category found',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.currentTheme.colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Create a category to start adding items',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.currentTheme.colorScheme.tertiary,
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            rightSlideTransition(context, const NewCategoryScreen());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.currentTheme.colorScheme.secondary,
            foregroundColor: AppTheme.currentTheme.colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text(
            'Create category',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
