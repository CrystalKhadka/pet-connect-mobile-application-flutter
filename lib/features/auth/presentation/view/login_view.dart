import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/core/common/widgets/my_yes_no_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/login_view_model.dart';
import '../widgets/my_text_field.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;
  bool obscurePassword = true;
  bool showYesNoDialog = true;
  bool isDialogShowing = false;

  final key = GlobalKey<FormState>();

  List<double> _gyroscopeValues = [];
  final List<StreamSubscription<dynamic>> _streamSubscription = [];

  @override
  void initState() {
    _streamSubscription.add(gyroscopeEvents!.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];

        _checkGyroscopeValues(_gyroscopeValues);
      });
    }));

    super.initState();
  }

  @override
  void dispose() {
    for (final subscription in _streamSubscription) {
      subscription.cancel();
    }
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _checkGyroscopeValues(List<double> values) async {
    const double threshold = 5; // Example threshold value, adjust as needed
    if (values.any((value) => value.abs() > threshold)) {
      if (showYesNoDialog && !isDialogShowing) {
        isDialogShowing = true;
        final result = await myYesNoDialog(
          title: 'Are you sure you want to send feedback?',
        );
        isDialogShowing = false;
        if (result) {
          showMySnackBar(
            message: 'Feedback sent',
            color: Colors.green,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Pet Connect',
                      style: TextStyle(
                        fontFamily: 'OpenSans Bold',
                        fontSize: 36,
                        color: Color.fromRGBO(23, 88, 110, 1),
                      ),
                    ),
                    const SizedBox(height: 48),
                    MyTextField(
                      controller: emailController,
                      prefixIcon: const Icon(Icons.email),
                      text: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    MyTextField(
                      controller: passwordController,
                      prefixIcon: const Icon(Icons.lock),
                      text: 'Password',
                      obscureText: obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value!;
                                });
                              },
                            ),
                            const Text('Remember me'),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            ref
                                .read(loginViewModelProvider.notifier)
                                .openForgotPasswordView();
                          },
                          child: const Text('Forgot password?'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (key.currentState!.validate()) {
                            ref.read(loginViewModelProvider.notifier).loginUser(
                                  emailController.text,
                                  passwordController.text,
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(23, 88, 110, 1),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Log in'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () {
                        ref
                            .read(loginViewModelProvider.notifier)
                            .getUserByGoogle();
                      },
                      icon: Image.asset('assets/icons/google.png', height: 24),
                      label: const Text('Continue with Google'),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () {
                        ref
                            .read(loginViewModelProvider.notifier)
                            .openRegisterView();
                      },
                      child: const Text("Don't have an account? Sign up"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
