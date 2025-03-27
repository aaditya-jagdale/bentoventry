import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:textile/modules/shared/widgets/colors.dart';
import 'package:textile/modules/shared/widgets/transitions.dart';
import 'package:textile/profile/screens/all_categories.dart';
import 'package:textile/profile/widgets/profile_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            ProfileTile(
              title: 'Profile',
              icon: 'assets/icons/person.svg',
              onTap: () {},
            ),
            ProfileTile(
              title: 'All Categories',
              icon: 'assets/icons/list.svg',
              onTap: () {
                rightSlideTransition(context, const AllCategoriesScreen());
              },
            ),
            ProfileTile(
              title: 'All Items',
              icon: 'assets/icons/list.svg',
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DottedLine(dashColor: AppColors.grey),
            ),
            ProfileTile(
              title: 'Privacy Policy',
              icon: 'assets/icons/privacy.svg',
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DottedLine(dashColor: AppColors.grey),
            ),
            ProfileTile(
              title: 'Logout',
              icon: 'assets/icons/logout.svg',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
