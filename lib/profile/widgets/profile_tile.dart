import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:textile/modules/shared/widgets/colors.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final String icon;
  final Function() onTap;
  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                title == 'Logout'
                    ? AppTheme.currentTheme.colorScheme.error
                    : AppTheme.currentTheme.colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color:
                      title == 'Logout'
                          ? AppTheme.currentTheme.colorScheme.error
                          : AppTheme.currentTheme.colorScheme.primary,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color:
                  title == 'Logout'
                      ? AppTheme.currentTheme.colorScheme.error
                      : AppTheme.currentTheme.colorScheme.primary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
