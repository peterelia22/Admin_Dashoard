import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../app_theme.dart';
import '../../../../core/helpers/build_snack_bar.dart';
import '../../../home/presentation/views/home_view.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  static const String routeName = '/signin';

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return _buildWebLayout();
    }
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Aman24",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 40),

              TextField(
                controller: emailController,
                cursorColor: AppTheme.primaryColor,
                decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  labelStyle: const TextStyle(color: AppTheme.black),
                  floatingLabelStyle: const TextStyle(
                    color: AppTheme.primaryColor,
                  ),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: AppTheme.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppTheme.primaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: passwordController,
                obscureText: true,
                cursorColor: AppTheme.primaryColor,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  labelStyle: const TextStyle(color: AppTheme.black),
                  floatingLabelStyle: const TextStyle(
                    color: AppTheme.primaryColor,
                  ),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppTheme.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppTheme.primaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();

                            if (email == 'admin@aman24.com') {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  );
                              if (context.mounted) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  HomeView.routeName,
                                );
                              }
                            } else {
                              buildSnackBar(
                                context: context,
                                title: 'خطا',
                                message: 'البريد الالكتروني غير صحيح',
                                contentType: ContentType.failure,
                              );
                            }
                          } on FirebaseAuthException {
                            buildSnackBar(
                              context: context,
                              title: 'خطا',
                              message: 'بيانات التسجيل غير صحيحة',
                              contentType: ContentType.failure,
                            );
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: AppTheme.white)
                      : const Text(
                          'تسجيل الدخول',
                          style: TextStyle(fontSize: 18, color: AppTheme.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWebLayout() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryColor.withOpacity(0.1),
              Colors.white,
              AppTheme.primaryColor.withOpacity(0.05),
            ],
          ),
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            padding: const EdgeInsets.all(40),
            child: Row(
              children: [
                // Left side - Branding
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aman24',
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'لوحة تحكم المسؤول',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'راقب وأدر جميع البلاغات بكفاءة',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Icon(
                        Icons.security,
                        size: 200,
                        color: AppTheme.primaryColor.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 80),
                // Right side - Login form
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(48),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'مرحباً بعودتك',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'سجل الدخول للوصول إلى لوحة التحكم',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),
                        TextField(
                          controller: emailController,
                          cursorColor: AppTheme.primaryColor,
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            labelText: 'البريد الإلكتروني',
                            labelStyle: const TextStyle(color: AppTheme.black),
                            floatingLabelStyle: const TextStyle(
                              color: AppTheme.primaryColor,
                            ),
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: AppTheme.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppTheme.primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          cursorColor: AppTheme.primaryColor,
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            labelText: 'كلمة المرور',
                            labelStyle: const TextStyle(color: AppTheme.black),
                            floatingLabelStyle: const TextStyle(
                              color: AppTheme.primaryColor,
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: AppTheme.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppTheme.primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _handleSignIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: AppTheme.white,
                                  )
                                : const Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppTheme.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (email == 'admin@aman24.com') {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (mounted) {
          Navigator.pushReplacementNamed(context, HomeView.routeName);
        }
      } else {
        buildSnackBar(
          context: context,
          title: 'خطا',
          message: 'البريد الالكتروني غير صحيح',
          contentType: ContentType.failure,
        );
      }
    } on FirebaseAuthException {
      buildSnackBar(
        context: context,
        title: 'خطا',
        message: 'بيانات التسجيل غير صحيحة',
        contentType: ContentType.failure,
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
