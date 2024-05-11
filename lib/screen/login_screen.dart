import 'package:final_assignment/common/my_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    var gap = const SizedBox(height: 20);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pet Connect',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Pet Connect',
                  style: TextStyle(fontSize: 40),
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/icons/icon.jpg',
                  width: 180,
                  height: 200,
                ),
              ),
              gap,
              const Text('Welcome!'),
              gap,
              MyTextField(
                controller: emailController,
                prefixIcon: const Icon(Icons.email),
                text: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              gap,
              MyTextField(
                controller: passwordController,
                prefixIcon: const Icon(Icons.lock),
                text: 'Password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
