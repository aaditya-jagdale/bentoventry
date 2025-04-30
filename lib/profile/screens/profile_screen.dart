import 'dart:convert';
import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textile/main.dart';
import 'package:textile/modules/shared/api/api_calls.dart';
import 'package:textile/modules/shared/widgets/colors.dart';
import 'package:textile/modules/shared/widgets/transitions.dart';
import 'package:textile/onboarding/screens/login_screen.dart';
import 'package:textile/profile/screens/all_categories.dart';
import 'package:textile/profile/screens/favourites_screen.dart';
import 'package:textile/profile/widgets/profile_tile.dart';
import 'package:textile/riverpod/category_items_rvpd.dart';
import 'package:textile/riverpod/theme_rvpd.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dark Mode",
                    style: TextStyle(
                      color: AppTheme.currentTheme.colorScheme.primary,
                    ),
                  ),
                  Switch(
                    value:
                        ref.watch(themeProvider).brightness == Brightness.dark,
                    onChanged: (value) {
                      setState(() {
                        ref.read(themeProvider.notifier).toggleTheme();
                        MyApp();
                      });
                    },
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.currentTheme.colorScheme.primary.withOpacity(
                  0.2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ProfileTile(
                    title: 'Profile',
                    icon: 'assets/icons/person.svg',
                    onTap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: DottedLine(
                      dashColor: AppTheme.currentTheme.colorScheme.tertiary,
                    ),
                  ),
                  ProfileTile(
                    title: 'All Categories',
                    icon: 'assets/icons/list.svg',
                    onTap: () {
                      rightSlideTransition(
                        context,
                        const AllCategoriesScreen(),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: DottedLine(
                      dashColor: AppTheme.currentTheme.colorScheme.tertiary,
                    ),
                  ),
                  ProfileTile(
                    title: 'All Items',
                    icon: 'assets/icons/list.svg',
                    onTap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: DottedLine(
                      dashColor: AppTheme.currentTheme.colorScheme.tertiary,
                    ),
                  ),
                  ProfileTile(
                    title: 'Favorites',
                    icon: 'assets/icons/favourite.svg',
                    onTap: () {
                      rightSlideTransition(context, const FavouritesScreen());
                    },
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.currentTheme.colorScheme.primary.withOpacity(
                  0.2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ProfileTile(
                title: 'Privacy Policy',
                icon: 'assets/icons/privacy.svg',
                onTap: () {},
              ),
            ),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.currentTheme.colorScheme.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ProfileTile(
                title: 'Logout',
                icon: 'assets/icons/logout.svg',
                onTap: () async {
                  await ApiCalls.logout();

                  clearAllAndPush(context, const LoginScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
