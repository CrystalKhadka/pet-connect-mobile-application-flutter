import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
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

  final _fnameController = TextEditingController(text: 'Crystal');
  final _lnameController = TextEditingController(text: "Khadka");
  final _emailController =
      TextEditingController(text: "khadkacrystal23@gmail.com");
  final _passwordController = TextEditingController(text: "12345678");
  final _confirmPasswordController = TextEditingController(text: "12345678");
  final _addressController = TextEditingController(text: 'KTM');
  final _phoneController = TextEditingController(text: '9843041037');
  final _birthDateController = TextEditingController();

  DateTime? _selectedDate;
  String _selectedGender = "male";
  bool _isObscure = true;

  final _gap = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 36),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: _fnameController,
                    text: 'First Name',
                    prefixIcon: const Icon(Icons.person),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  _gap,
                  MyTextField(
                    controller: _lnameController,
                    text: 'Last Name',
                    prefixIcon: const Icon(Icons.person),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  _gap,
                  MyTextField(
                    controller: _emailController,
                    text: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      if (!value.contains('.')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  _gap,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  _gap,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  ),
                  _gap,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your birth date';
                      }
                      return null;
                    },
                  ),
                  _gap,
                  MyTextField(
                    controller: _addressController,
                    text: 'Address',
                    prefixIcon: const Icon(Icons.location_on),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  _gap,
                  MyTextField(
                    controller: _phoneController,
                    text: 'Phone',
                    prefixIcon: const Icon(Icons.phone),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (value.length < 10) {
                        return 'Phone number must be at least 10 digits';
                      }
                      return null;
                    },
                  ),
                  _gap,
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
                  const SizedBox(height: 10),
                  MyButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AuthEntity auth = AuthEntity(
                            firstName: _fnameController.text,
                            lastName: _lnameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            phone: _phoneController.text,
                            address: _addressController.text,
                            gender: _selectedGender,
                            birthDate: _birthDateController.text);
                        ref
                            .read(registerViewModelProvider.notifier)
                            .registerUser(auth);
                      }
                    },
                    bgColor: const Color.fromRGBO(23, 88, 110, 1),
                    fgColor: Colors.white,
                    child: const Text('Sign Up'),
                  ),
                  TextButton(
                    onPressed: () {
                      ref
                          .read(registerViewModelProvider.notifier)
                          .openLoginView();
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
        ),
      ),
    );
  }
}
