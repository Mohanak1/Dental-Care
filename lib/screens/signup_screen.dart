import 'package:flutter/material.dart';

import '../app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import 'main_shell.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController(text: 'Muhana kemabity');
  final _emailController = TextEditingController(text: 'muhana@gmail.com');
  final _passwordController = TextEditingController(text: 'password');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() {
    AppScope.of(context, listen: false).signUp(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Account created locally.')));
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(MainShell.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.sky,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.person_add_alt_1_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'Create your account',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Use any details. This app keeps everything local on device.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppColors.muted),
                  ),
                  const SizedBox(height: 28),
                  AppTextField(
                    controller: _nameController,
                    label: 'Full name',
                    hint: 'Your name',
                    icon: Icons.person_outline_rounded,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 14),
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
                    hint: 'Create any password',
                    icon: Icons.lock_outline_rounded,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    label: 'Create account',
                    icon: Icons.check_circle_outline_rounded,
                    onPressed: _signUp,
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
