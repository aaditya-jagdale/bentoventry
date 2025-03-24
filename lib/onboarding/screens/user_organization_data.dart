import 'package:flutter/material.dart';
import 'package:textile/modules/shared/api/api_calls.dart';
import 'package:textile/modules/shared/screens/splash_screen.dart';
import 'package:textile/modules/shared/widgets/buttons.dart';
import 'package:textile/modules/shared/widgets/colors.dart';
import 'package:textile/modules/shared/widgets/custom_progress_indicator.dart';
import 'package:textile/modules/shared/widgets/transitions.dart';

class UserOrganizationData extends StatefulWidget {
  const UserOrganizationData({super.key});

  @override
  State<UserOrganizationData> createState() => _UserOrganizationDataState();
}

class _UserOrganizationDataState extends State<UserOrganizationData> {
  final controller = TextEditingController();
  bool _showError = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Organization')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.white, fontSize: 16),
              decoration: InputDecoration(
                fillColor: AppColors.greyBg,
                errorText:
                    _showError && controller.text.isEmpty
                        ? 'Please enter a valid organization name'
                        : null,
                hintText: 'Organization Name',
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
                    ApiCalls.createUserOrg(controller.text.trim())
                        .then((_) {
                          clearAllAndPush(context, const SplashScreen());
                          setState(() {
                            _isLoading = false;
                          });
                        })
                        .onError((error, _) {
                          print(error);
                          setState(() {
                            _isLoading = false;
                          });
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
