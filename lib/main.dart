import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/ui/theme.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';

void main() {
  runApp(const ProviderScope(child: LunaApp()));
}

class LunaApp extends ConsumerWidget {
  const LunaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Luna',
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: ThemeMode.system,
      home: const OnboardingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

