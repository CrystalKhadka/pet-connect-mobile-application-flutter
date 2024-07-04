import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/core/common/my_yes_no_dialog.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/login_view_model.dart';
import 'package:final_assignment/features/auth/presentation/widgets/my_button.dart';
import 'package:final_assignment/features/auth/presentation/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LocalAuthentication _localAuth = LocalAuthentication();
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  const Center(
                    child: Text(
                      'Pet Connect',
                      style: TextStyle(
                        fontFamily: 'OpenSans Bold',
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      fontFamily: 'Montserrat Bold Italic',
                    ),
                  ),
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
                  const SizedBox(height: 20),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyButton(
                        onPressed: () {
                          // TODO: Implement Forgot Password functionality
                        },
                        child: const Text(
                          'Forgot your password?',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: MyButton(
                                onPressed: () {
                                  if (key.currentState!.validate()) {
                                    ref
                                        .read(authViewModelProvider.notifier)
                                        .loginUser(
                                          emailController.text,
                                          passwordController.text,
                                        );
                                  }
                                },
                                bgColor: const Color.fromRGBO(23, 88, 110, 1),
                                fgColor: Colors.white,
                                child: const Text('Log in'),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(authViewModelProvider.notifier)
                                    .fingerPrintLogin();
                              },
                              icon: const Icon(Icons.fingerprint),
                            )
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              ref
                                  .read(loginViewModelProvider.notifier)
                                  .openRegisterView();
                            },
                            child: const Text(
                              "Don't have an account? Sign up",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.7,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 10,
                              ),
                              child: Text(
                                'Continue with',
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.7,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        MyButton(
                          onPressed: () {
                            //TODO:  Implement Google Sign-in
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/icons/google.png',
                                height: 50,
                              ),
                              const Text('Google'),
                            ],
                          ),
                        ),
                      ],
                    ),
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
