import 'package:flutter/material.dart';

import '../app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import 'main_shell.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'Muhana@gmail.com');
  final _passwordController = TextEditingController(text: 'password');
  bool _rememberMe = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    AppScope.of(
      context,
      listen: false,
    ).login(email: _emailController.text, password: _passwordController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signed in with local dummy login.')),
    );
    Navigator.of(context).pushReplacementNamed(MainShell.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _AuthLogo(),
                  const SizedBox(height: 30),
                  Text(
                    'Welcome back',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manage your dental visits and book appointments in seconds.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppColors.muted),
                  ),
                  const SizedBox(height: 28),
                  AppTextField(
                    controller: _emailController,
                    label: 'Email',
                    hint: 'patient@email.com',
                    icon: Icons.mail_outline_rounded,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 14),
                  AppTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hint: 'Enter any password',
                    icon: Icons.lock_outline_rounded,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() => _rememberMe = value ?? true);
                        },
                      ),
                      const Text('Remember me'),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password reset is simulated.'),
                            ),
                          );
                        },
                        child: const Text('Forgot?'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    label: 'Sign in',
                    icon: Icons.login_rounded,
                    onPressed: _login,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Flexible(child: Text('New to DentalCare?')),
                      TextButton(
                        onPressed: () => Navigator.of(
                          context,
                        ).pushNamed(SignUpScreen.routeName),
                        child: const Text('Create account'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthLogo extends StatelessWidget {
  const _AuthLogo();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.health_and_safety_outlined,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Text('DentalCare', style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
