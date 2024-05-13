import 'package:final_assignment/common/my_button.dart';
import 'package:final_assignment/common/my_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pet Connect',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // color: Colors.grey,
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
                    height: 180,
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Welcome!'),
                // const SizedBox(height: 20),
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
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyButton(
                      onPressed: () {},
                      child: const Text('Forgot your password?'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 200,
                          child: MyButton(
                            onPressed: () {
                              debugPrint(
                                'email : ${emailController.text} and password: ${passwordController.text}',
                              );
                            },
                            bgColor: const Color.fromRGBO(23, 88, 110, 1),
                            fgColor: Colors.white,
                            child: const Text('Log in'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Continue With'),
                        MyButton(
                          onPressed: () {},
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Don't have an account"),
                        MyButton(
                          onPressed: () {},
                          child: const Text('Sign up'),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
