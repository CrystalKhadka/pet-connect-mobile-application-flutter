import 'package:final_assignment/common/my_text_field.dart';
import 'package:final_assignment/screen/login_screen.dart';
import 'package:flutter/material.dart';

import '../common/my_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final birthDateController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  String selectedGender = "male";
  bool obscurePassword = true;

  final _key = GlobalKey<FormState>();

  final _gap = const SizedBox(height: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(23, 88, 110, 0.8),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'Sign Up now',
                      style: TextStyle(fontSize: 36),
                    ),
                  ),
                  Image.asset(
                    'assets/images/icon.jpg',
                    height: 180,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: nameController,
                    text: 'Full Name',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: emailController,
                    text: 'Email',
                    prefixIcon: const Icon(Icons.email),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: passwordController,
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
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: confirmPasswordController,
                    text: 'Confirm Password',
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
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: birthDateController,
                    text: 'Birth Date',
                    prefixIcon: const Icon(Icons.calendar_month),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    controller: addressController,
                    text: 'Address',
                    prefixIcon: const Icon(Icons.pin_drop),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // const Text('Gender:'),
                        Row(
                          children: [
                            const Text('Male'),
                            Radio<String>(
                              value: 'male',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value!;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Female'),
                            Radio<String>(
                              value: 'female',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value!;
                                });
                              },
                            ),
                          ],
                        ),
                        // Add more Radio widgets for other options here
                      ],
                    ),
                  ),
                  _gap,
                  MyTextField(
                    controller: phoneController,
                    text: 'Phone',
                    prefixIcon: const Icon(Icons.phone),
                  ),
                  _gap,
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: MyButton(
                            onPressed: () {
                              if (_key.currentState!.validate()) {}
                            },
                            bgColor: const Color.fromRGBO(23, 88, 110, 1),
                            fgColor: Colors.white,
                            child: const Text('Sign Up'),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const LoginScreen();
                              }));
                            },
                            child: const Text(
                              "Already have an account? Log in",
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
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
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
      ),
    );
  }
}
