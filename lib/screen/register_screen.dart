import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/my_button.dart';
import '../common/my_text_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();

  DateTime? _selectedDate;
  String _selectedGender = "male";
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(23, 88, 110, 0.8),
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 36),
                textAlign: TextAlign.center,
              ),
              Image.asset(
                'assets/images/icon.jpg',
                height: 180,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: _fnameController,
                text: 'First Name',
                prefixIcon: const Icon(Icons.person),
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _lnameController,
                text: 'Last Name',
                prefixIcon: const Icon(Icons.person),
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _emailController,
                text: 'Email',
                prefixIcon: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _passwordController,
                text: 'Password',
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                prefixIcon: const Icon(Icons.lock),
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _confirmPasswordController,
                text: 'Confirm Password',
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                prefixIcon: const Icon(Icons.lock),
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _birthDateController,
                text: 'Birth Date',
                prefixIcon: const Icon(Icons.calendar_today),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.date_range),
                  onPressed: () => _selectDate(context),
                ),
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _addressController,
                text: 'Address',
                prefixIcon: const Icon(Icons.location_on),
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _phoneController,
                text: 'Phone',
                prefixIcon: const Icon(Icons.phone),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Gender:',
                      style: Theme.of(context).textTheme.titleMedium),
                  Radio<String>(
                    value: 'male',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  const Text('Male'),
                  Radio<String>(
                    value: 'female',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  const Text('Female'),
                ],
              ),
              const SizedBox(height: 20),
              MyButton(
                onPressed: _submitForm,
                bgColor: const Color.fromRGBO(23, 88, 110, 1),
                fgColor: Colors.white,
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
                },
                child: const Text(
                  "Already have an account? Log in",
                  style: TextStyle(color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthDateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing Data'),
        ),
      );

      // Add a delay before showing the success dialog
      Future.delayed(const Duration(seconds: 2), () {
        // Show the success dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Registration Success'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      });
    }
  }
}
