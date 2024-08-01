import 'package:final_assignment/features/forgot_password/presentation/state/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/forgot_password_view_model.dart';

class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  ConsumerState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  int _timer = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPasswordViewModelProvider);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[100]!, Colors.purple[100]!],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.9,
              constraints: const BoxConstraints(maxWidth: 400),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildOptionButton('Email', 'email', state),
                      const SizedBox(width: 20),
                      _buildOptionButton('Phone', 'phone', state),
                    ],
                  ),
                  const SizedBox(height: 20),
                  state.method == 'email'
                      ? _buildEmailField()
                      : Column(
                          children: [
                            TextFormField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Phone',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                            if (state.isSent) ...[
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _otpController,
                                decoration: const InputDecoration(
                                  labelText: 'OTP',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  labelText: 'New Password',
                                  border: OutlineInputBorder(),
                                ),
                                obscureText: true,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _confirmPasswordController,
                                decoration: const InputDecoration(
                                  labelText: 'Confirm Password',
                                  border: OutlineInputBorder(),
                                ),
                                obscureText: true,
                              ),
                            ],
                          ],
                        ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      if (!state.isSent) {
                        ref.read(forgotPasswordViewModelProvider.notifier).send(
                              state.method == 'email'
                                  ? _emailController.text
                                  : _phoneController.text,
                            );
                      } else {
                        ref
                            .read(forgotPasswordViewModelProvider.notifier)
                            .verifyOtp(
                              _otpController.text,
                              _phoneController.text,
                              _passwordController.text,
                            );
                      }
                    },
                    child: Text(
                      state.method == 'email'
                          ? 'Send Email'
                          : state.isSent
                              ? 'Verify OTP and Reset Password'
                              : 'Send OTP',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  if (_timer > 0) _buildTimerText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(
      String label, String value, ForgotPasswordState state) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            state.method == value ? Colors.blue[100] : Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: _timer == 0
          ? () => ref
              .read(forgotPasswordViewModelProvider.notifier)
              .changeMethod(value)
          : null,
      child: Text(label),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildTimerText() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        'Please wait $_timer seconds before trying again.',
        style: TextStyle(color: Colors.grey[700]),
      ),
    );
  }

  void _startTimer() {
    setState(() => _timer = 60);
    Future.delayed(const Duration(seconds: 1), () {
      if (_timer > 0) {
        setState(() => _timer--);
        _startTimer();
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
