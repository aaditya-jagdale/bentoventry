import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textile/home/models/user_org_model.dart';
import 'package:textile/home/screens/home_screen.dart';
import 'package:textile/modules/shared/api/api_calls.dart';
import 'package:textile/modules/shared/widgets/colors.dart';
import 'package:textile/modules/shared/widgets/custom_progress_indicator.dart';
import 'package:textile/modules/shared/widgets/transitions.dart';
import 'package:textile/onboarding/screens/user_organization_data.dart';
import 'package:textile/riverpod/user_org_rvpd.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Future<void> getUserOrg() async {
    final res = await ApiCalls.getUserOrg();
    if (res.isEmpty) {
      clearAllAndPush(context, const UserOrganizationData());
    } else {
      ref
          .read(userOrgProvider.notifier)
          .setUserOrg(UserOrgModel.fromJson(res.first));
      clearAllAndPush(context, const HomeScreen());
    }
  }

  @override
  void initState() {
    getUserOrg();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bentoventry',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  shadows: [
                    Shadow(
                      color: AppColors.white.withOpacity(0.25),
                      blurRadius: 16,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              Text(
                'Inventory management system for businesses',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.white,
                  shadows: [
                    Shadow(
                      color: AppColors.white.withOpacity(0.25),
                      blurRadius: 16,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              CustomProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
