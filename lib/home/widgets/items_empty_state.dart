import 'package:flutter/material.dart';
import 'package:textile/home/screens/new_item_screen.dart';
import 'package:textile/modules/shared/widgets/colors.dart';
import 'package:textile/modules/shared/widgets/transitions.dart';

class ItemsEmptyState extends StatelessWidget {
  const ItemsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_circle_outline_rounded,
          size: 48,
          color: AppTheme.currentTheme.colorScheme.tertiary,
        ),
        const SizedBox(height: 16, width: double.infinity),
        Text(
          'No items found',
          style: TextStyle(
            fontSize: 20,
            color: AppTheme.currentTheme.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Create an item to start adding items',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.currentTheme.colorScheme.tertiary,
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            upSlideTransition(context, const NewItemScreen());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.currentTheme.colorScheme.primary,
            foregroundColor: AppTheme.currentTheme.colorScheme.secondary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text(
            'Create item',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
