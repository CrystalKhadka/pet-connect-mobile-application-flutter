import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/login_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
])
void main() {
  late AuthUseCase mockAuthUseCase;
  late LoginViewNavigator mockLoginViewNavigator;
  late ProviderContainer container;

  setUp(
    () {
      mockAuthUseCase = MockAuthUseCase();
      mockLoginViewNavigator = MockLoginViewNavigator();
      container = ProviderContainer(
        overrides: [
          loginViewModelProvider.overrideWith(
            (ref) => LoginViewModel(mockLoginViewNavigator, mockAuthUseCase),
          )
        ],
      );
    },
  );

  test(
    'Login test using correct email and password',
    () async {
      const correctEmail = 'khadkacrystal@gmail.com';
      const correctPassword = '12345678';

      // Arrange
      when(mockAuthUseCase.loginUser(any, any)).thenAnswer(
        (innovation) {
          final email = innovation.positionalArguments[0] as String;
          final password = innovation.positionalArguments[1] as String;

          return Future.value(
            email == correctEmail && password == correctPassword
                ? const Right(true)
                : Left(
                    Failure(error: 'Invalid'),
                  ),
          );
        },
      );

      // Act
      await container.read(loginViewModelProvider.notifier).loginUser(
            'khadkacrystal@gmail.com',
            '12345678',
          );

      // Assert
      final loginState = container.read(loginViewModelProvider);
      expect(loginState.error, isNull);
    },
  );

  tearDown(
    () {
      container.dispose();
    },
  );
}
