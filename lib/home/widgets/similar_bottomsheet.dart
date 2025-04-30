import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:textile/home/models/category_item_model.dart';
import 'package:textile/items/screens/filters_screen.dart';
import 'package:textile/modules/shared/widgets/colors.dart';
import 'package:textile/modules/shared/widgets/transitions.dart';

class SimilarBottomSheet extends StatelessWidget {
  final CategoryItemModel item;
  const SimilarBottomSheet({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.currentTheme.colorScheme.secondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find similar:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.currentTheme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 10),
          _buildFilterRow(
            icon: 'assets/icons/stack.svg',
            label: 'Material',
            value: item.material,
            onPressed: () {
              Navigator.pop(context);
              fadeTransition(
                context,
                FiltersScreen(column: 'material', value: item.material),
              );
            },
          ),
          if (item.gsm != 0)
            _buildFilterRow(
              icon: 'assets/icons/weight.svg',
              label: 'Weight (gsm)',
              value: "${item.gsm}gsm",
              onPressed: () {
                Navigator.pop(context);
                fadeTransition(
                  context,
                  FiltersScreen(
                    column: 'gsm',
                    value: item.gsm.toString(),
                    qty: true,
                  ),
                );
              },
            ),

          _buildFilterRow(
            icon: 'assets/icons/pattern.svg',
            label: 'Pattern',
            value: item.pattern,
            showLine: false,
            onPressed: () {
              Navigator.pop(context);
              fadeTransition(
                context,
                FiltersScreen(column: 'pattern', value: item.pattern),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildFilterRow({
    required String icon,
    required String label,
    required String value,
    bool showLine = true,
    Function()? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  color: AppTheme.currentTheme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          color: AppTheme.currentTheme.colorScheme.primary,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        value,
                        style: TextStyle(
                          color: AppTheme.currentTheme.colorScheme.primary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showLine)
            DottedLine(dashColor: AppTheme.currentTheme.colorScheme.tertiary),
        ],
      ),
    );
  }
}
