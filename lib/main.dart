import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textile/modules/shared/screens/splash_screen.dart';
import 'package:textile/modules/shared/widgets/colors.dart';
import 'package:textile/onboarding/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON']!,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return ProviderScope(
      child: MaterialApp(
        title: 'Bentoventry',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.blackbg,
          textTheme: GoogleFonts.instrumentSansTextTheme(
            Typography.whiteCupertino,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: AppColors.white,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.blackbg,
            foregroundColor: AppColors.white,
            titleTextStyle: GoogleFonts.instrumentSans(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        home:
            supabase.auth.currentUser == null
                ? const LoginScreen()
                : const SplashScreen(),
      ),
    );
  }
}
