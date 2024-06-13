import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/register_view_model.dart';
import 'package:final_assignment/features/auth/presentation/widgets/my_button.dart';
import 'package:final_assignment/features/auth/presentation/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
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
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
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
                obscureText: _isObscure,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
                prefixIcon: const Icon(Icons.lock),
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _confirmPasswordController,
                text: 'Confirm Password',
                obscureText: _isObscure,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
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
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _selectedDate = picked;
                          _birthDateController.text =
                              picked.toString().split(' ')[0];
                        });
                      }
                    }),
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
                onPressed: () {
                  AuthEntity auth = AuthEntity(
                      fname: _fnameController.text,
                      lname: _lnameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                      phone: _phoneController.text,
                      address: _addressController.text,
                      gender: _selectedGender,
                      date: _birthDateController.text);
                  ref.read(authViewModelProvider.notifier).registerUser(auth);
                },
                bgColor: const Color.fromRGBO(23, 88, 110, 1),
                fgColor: Colors.white,
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  ref.read(registerViewModelProvider.notifier).openLoginView();
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
}
