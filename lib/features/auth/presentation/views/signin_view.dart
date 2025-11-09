import 'package:admin_dashboard/app_theme.dart';
import 'package:admin_dashboard/core/helpers/build_snack_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                  labelText: 'Email',
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
                  labelText: 'Password',
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
                          } on FirebaseAuthException catch (e) {
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
                          'Login',
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
}
