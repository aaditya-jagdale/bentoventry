import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:textile/home/screens/home_screen.dart';
import 'package:textile/modules/shared/api/api_calls.dart';
import 'package:textile/modules/shared/widgets/buttons.dart';
import 'package:textile/modules/shared/widgets/colors.dart';
import 'package:textile/modules/shared/widgets/custom_progress_indicator.dart';
import 'package:textile/modules/shared/widgets/transitions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
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
                        color: AppTheme.currentTheme.colorScheme.secondary,
                        shadows: [
                          Shadow(
                            color: AppTheme.currentTheme.colorScheme.secondary
                                .withOpacity(0.25),
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
                        color: AppTheme.currentTheme.colorScheme.secondary,
                        shadows: [
                          Shadow(
                            color: AppTheme.currentTheme.colorScheme.secondary
                                .withOpacity(0.25),
                            blurRadius: 16,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isLoading) CustomProgressIndicator(),
            if (!_isLoading)
              Padding(
                padding: const EdgeInsets.all(10),
                child: PrimaryButton(
                  title: 'Google',
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    ApiCalls.login()
                        .then((res) {
                          final Session? session = res.session;
                          final User? user = res.user;

                          if (session == null || user == null) {
                            throw Exception(
                              'Login failed - invalid credentials',
                            );
                          }

                          // Store the session token if needed
                          final String accessToken = session.accessToken;
                          final String? refreshToken = session.refreshToken;

                          if (refreshToken == null) {
                            throw Exception('Login failed - missing tokens');
                          }

                          clearAllAndPush(context, const HomeScreen());
                          setState(() {
                            _isLoading = true;
                          });
                        })
                        .onError((error, stackTrace) {
                          setState(() {
                            _isLoading = false;
                          });
                        });
                  },
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
