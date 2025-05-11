import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:textile/modules/shared/widgets/colors.dart';

class ItemListTile extends StatelessWidget {
  final String icon;
  final String title;
  final String value;
  final bool line;
  const ItemListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.line = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                  AppTheme.currentTheme.colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: AppTheme.currentTheme.colorScheme.primary,
                ),
              ),
              const Spacer(),
              Text(
                value,
                style: TextStyle(
                  color: AppTheme.currentTheme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        if (line)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DottedLine(
              dashColor: AppTheme.currentTheme.colorScheme.tertiary,
              dashGapLength: 6,
            ),
          ),
      ],
    );
  }
}
