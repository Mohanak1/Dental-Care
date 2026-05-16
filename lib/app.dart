import 'package:flutter/material.dart';

import 'app_state.dart';
import 'screens/login_screen.dart';
import 'screens/main_shell.dart';
import 'screens/signup_screen.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

class DentalCareApp extends StatefulWidget {
  const DentalCareApp({super.key});

  @override
  State<DentalCareApp> createState() => _DentalCareAppState();
}

class _DentalCareAppState extends State<DentalCareApp> {
  final AppState _appState = AppState();

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      notifier: _appState,
      child: MaterialApp(
        title: 'DentalCare',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (_) => const SplashScreen(),
          LoginScreen.routeName: (_) => const LoginScreen(),
          SignUpScreen.routeName: (_) => const SignUpScreen(),
          MainShell.routeName: (_) => const MainShell(),
        },
      ),
    );
  }
}
