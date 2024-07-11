import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/register_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_test.mocks.dart';
import 'register_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<RegisterViewNavigator>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthUseCase mockAuthUseCase;
  late RegisterViewNavigator mockRegisterViewNavigator;
  late ProviderContainer container;

  setUp(
    () {
      mockAuthUseCase = MockAuthUseCase();
      mockRegisterViewNavigator = MockRegisterViewNavigator();

      container = ProviderContainer(overrides: [
        registerViewModelProvider.overrideWith(
          (ref) => RegisterViewModel(
            mockRegisterViewNavigator,
            mockAuthUseCase,
          ),
        )
      ]);
    },
  );

  test(
    'Register new user test with all details test',
    () async {
      // Arrange
      when(mockAuthUseCase.registerUser(any)).thenAnswer((innovation) {
        final auth = innovation.positionalArguments[0] as AuthEntity;

        return Future.value(
          auth.firstName.isNotEmpty &&
                  auth.lastName.isNotEmpty &&
                  auth.email.isNotEmpty &&
                  auth.password.isNotEmpty &&
                  auth.birthDate.isNotEmpty &&
                  auth.address.isNotEmpty &&
                  auth.gender.isNotEmpty &&
                  auth.phone.isNotEmpty &&
                  auth.email.contains('@') &&
                  auth.email.contains('.') &&
                  auth.phone.length == 10
              ? const Right(true)
              : Left(
                  Failure(error: 'Invalid'),
                ),
        );
      });

      // Act
      await container.read(registerViewModelProvider.notifier).registerUser(
          const AuthEntity(
              firstName: 'Crystal',
              lastName: 'khadka',
              email: 'khadka@gmail.com',
              password: '12345678',
              phone: '1234567890',
              address: 'KTM',
              gender: 'Male',
              birthDate: '12/12/2000'));

      final state = container.read(registerViewModelProvider);

      // Assert
      expect(state.isLoading, false);
      expect(state.error, null);
    },
  );

  tearDown(
    () {
      container.dispose();
    },
  );
}
