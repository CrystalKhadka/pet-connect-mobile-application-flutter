import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/login_view_model.dart';
import 'package:final_assignment/features/auth/presentation/widgets/my_button.dart';
import 'package:final_assignment/features/auth/presentation/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  final key = GlobalKey<FormState>();

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
                  const SizedBox(
                    height: 50,
                  ),
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
                        SizedBox(
                          width: double.infinity,
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
