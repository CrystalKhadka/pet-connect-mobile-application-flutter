import 'package:final_assignment/features/auth/presentation/widgets/my_button.dart';
import 'package:final_assignment/features/auth/presentation/widgets/my_text_field.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/login_view_model.dart';
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
  bool termsAccepted = false;
  bool obscurePassword = true;

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(23, 88, 110, 0.8),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Pet Connect',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'assets/images/icon.jpg',
                    width: 180,
                    height: 180,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome!',
                  style: TextStyle(
                    fontFamily: 'Montserrat Bold Italic',
                  ),
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: emailController,
                  prefixIcon: const Icon(Icons.email),
                  text: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: passwordController,
                  prefixIcon: const Icon(Icons.lock),
                  text: 'Password',
                  obscureText: authState.isObscure,
                  suffixIcon: IconButton(
                    icon: Icon(
                      authState.isObscure
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      ref
                          .read(authViewModelProvider.notifier)
                          .obscurePassword();
                    },
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: authState.termsAndConditions,
                      onChanged: (value) {
                        ref
                            .read(authViewModelProvider.notifier)
                            .termsAndConditions();
                      },
                    ),
                    const Text('I accept the terms and conditions'),
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
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: MyButton(
                          onPressed: () {},
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
                        fgColor: Colors.black,
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
    );
  }
}
