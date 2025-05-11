import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textile/modules/shared/screens/splash_screen.dart';
import 'package:textile/onboarding/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:textile/riverpod/theme_rvpd.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supabase = Supabase.instance.client;

    return MaterialApp(
      title: 'Bentoventry',
      theme: ref.watch(themeProvider),
      home:
          supabase.auth.currentUser == null
              ? const LoginScreen()
              : const SplashScreen(),
    );
  }
}
