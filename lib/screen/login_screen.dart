import 'package:final_assignment/common/my_button.dart';
import 'package:final_assignment/common/my_text_field.dart';
import 'package:final_assignment/screen/dashboard_screen.dart';
import 'package:final_assignment/screen/register_screen.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final key = GlobalKey<FormState>();
    UserModel? userModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pet Connect',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: key,
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
                    'assets/images/icon.jpg',
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
                              if (key.currentState!.validate()) {
                                userModel = UserModel(
                                    email: emailController.text,
                                    password: passwordController.text);
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
                                      content: const Text(
                                          "You have entered wrong email or password"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            color: Colors.green,
                                            padding: const EdgeInsets.all(14),
                                            child: const Text(
                                              "Okay",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Don't have an account"),
                        MyButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const RegisterScreen();
                            }));
                          },
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
