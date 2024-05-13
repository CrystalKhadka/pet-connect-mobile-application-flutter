import 'package:flutter/material.dart';

import '../common/my_button.dart';
import '../common/my_text_field.dart';
import '../model/user_model.dart';
import 'dashboard_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool termsAccepted = false;
  bool obscurePassword = true;

  final key = GlobalKey<FormState>();
  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Connect'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: emailController,
                  prefixIcon: const Icon(Icons.email),
                  text: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: passwordController,
                  prefixIcon: const Icon(Icons.lock),
                  text: 'Password',
                  obscureText: obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          termsAccepted = value ?? false;
                        });
                      },
                    ),
                    const Text('I accept the terms and conditions'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
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
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      MyButton(
                        onPressed: () {
                          _login();
                        },
                        bgColor: const Color.fromRGBO(23, 88, 110, 1),
                        fgColor: Colors.white,
                        child: const Text('Log in'),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Continue With',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const RegisterScreen();
                          }));
                        },
                        child: const Text(
                          "Don't have an account? Sign up",
                          style: TextStyle(color: Colors.blue),
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

  void _login() {
    if (key.currentState!.validate() && termsAccepted) {
      userModel = UserModel(
        email: emailController.text,
        password: passwordController.text,
      );
      if (userModel!.validate()) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const DashboardScreen();
            },
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Error"),
            content: const Text("You have entered wrong email or password"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text(
                  "Okay",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        );
      }
    }
  }
}
