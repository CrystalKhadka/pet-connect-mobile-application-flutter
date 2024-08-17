import 'package:dartz/dartz.dart';
import 'package:final_assignment/app/navigator_key/navigator_key.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/google/google_service.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/view/login_view.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../unit_test/current_user_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthUseCase mockAuthUseCase;

  late GoogleSignInService googleSignInService;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
  });

  group("LoginView Widget Tests", () {
    testWidgets('renders LoginView', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const LoginView(),
            navigatorKey: AppNavigator.navigatorKey,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify that the LoginView is rendered
      expect(find.byType(LoginView), findsOneWidget);
    });

    testWidgets('Login form field and button interaction', (tester) async {
      // Arrange
      const correctEmail = 'test@gmail.com';
      const correctPassword = 'testtest';

      when(mockAuthUseCase.loginUser(any, any)).thenAnswer((invocation) {
        final email = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        return Future.value(email == correctEmail && password == correctPassword
            ? const Right(true)
            : Left(Failure(error: 'Invalid Credentails')));
      });

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            loginViewModelProvider.overrideWith(
              (ref) => LoginViewModel(
                authUseCase: mockAuthUseCase,
                navigator: LoginViewNavigator(),
                googleSignInService: GoogleSignInService(),
              ),
            )
          ],
          child: MaterialApp(
            home: const LoginView(),
            navigatorKey: AppNavigator.navigatorKey,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify that the form fields and buttons are present
      expect(find.byType(TextFormField),
          findsNWidgets(2)); // Email and Password fields
      expect(find.byType(ElevatedButton), findsOneWidget); // Login button

      // Enter text into email and password fields
      await tester.enterText(
          find.byType(TextFormField).at(0), 'test@gmail.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'testtest');

      // Tap on the login button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify that the login button is still present (indicating the user is still on the login screen)
      expect(find.text('Pet Categories'), findsOneWidget);
    });
  });
}
