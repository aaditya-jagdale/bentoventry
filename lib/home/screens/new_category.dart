import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textile/modules/shared/api/api_calls.dart';
import 'package:textile/modules/shared/screens/splash_screen.dart';
import 'package:textile/modules/shared/widgets/buttons.dart';
import 'package:textile/modules/shared/widgets/colors.dart';
import 'package:textile/modules/shared/widgets/custom_progress_indicator.dart';
import 'package:textile/modules/shared/widgets/transitions.dart';
import 'package:textile/riverpod/user_org_rvpd.dart';

class NewCategoryScreen extends ConsumerStatefulWidget {
  const NewCategoryScreen({super.key});

  @override
  ConsumerState<NewCategoryScreen> createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends ConsumerState<NewCategoryScreen> {
  final controller = TextEditingController();
  bool _showError = false;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'New Category',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.name,
              style: TextStyle(color: AppColors.white, fontSize: 16),
              decoration: InputDecoration(
                fillColor: AppColors.greyBg,
                errorText:
                    _showError && controller.text.isEmpty
                        ? 'Please enter a valid category name'
                        : null,
                hintText: 'Category Name',
                hintStyle: TextStyle(
                  color: AppColors.grey.withOpacity(0.5),
                  fontWeight: FontWeight.normal,
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: EdgeInsets.all(16),
                enabledBorder: OutlineInputBorder(
                  // borderSide: BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (_isLoading)
              const CustomProgressIndicator()
            else
              PrimaryButton(
                title: 'Done',
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _showError = true;
                  });
                  if (controller.text.isNotEmpty) {
                    int orgId = ref.read(userOrgProvider)!.id;

                    ApiCalls.createCategory(controller.text, orgId).then((_) {
                      setState(() {
                        _isLoading = false;
                      });
                      clearAllAndPush(context, const SplashScreen());
                    });
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
