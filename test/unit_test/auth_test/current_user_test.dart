import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:final_assignment/features/profile/presentation/viewmodel/current_user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'current_user_test_data/current_user_test_data.dart';
import 'login_test.mocks.dart';

void main() {
  late AuthUseCase mockAuthUseCase;
  late ProviderContainer container;

  setUp(
    () {
      mockAuthUseCase = MockAuthUseCase();
      container = ProviderContainer(
        overrides: [
          currentUserViewModelProvider.overrideWith(
            (ref) => CurrentUserViewModel(authUseCase: mockAuthUseCase),
          ),
        ],
      );
    },
  );

  group('Current user view model test', () {
    test('Get current user test', () async {
      // Arrange
      when(mockAuthUseCase.getCurrentUser()).thenAnswer(
          (_) => Future.value(Right(CurrentUserTestData.getAuthEntity())));

      when(mockAuthUseCase.getFingerPrintId()).thenAnswer(
        (_) => Future.value(
          Right(CurrentUserTestData.getAuthEntity().id ?? ''),
        ),
      );

      // Act
      await container
          .read(currentUserViewModelProvider.notifier)
          .getCurrentUser();

      // Assert
      final currentState = container.read(currentUserViewModelProvider);
      expect(currentState.authEntity, CurrentUserTestData.getAuthEntity());
      expect(currentState.isLoading, false);
    });

    // Check Initialize
    test('check initialize test', () async {
      // Arrange
      when(mockAuthUseCase.getCurrentUser()).thenAnswer(
          (_) => Future.value(Right(CurrentUserTestData.getAuthEntity())));

      when(mockAuthUseCase.getFingerPrintId()).thenAnswer(
        (_) => Future.value(
          Right(CurrentUserTestData.getAuthEntity().id ?? ''),
        ),
      );

      // Act
      await container.read(currentUserViewModelProvider.notifier).initialize();

      // Assert
      final currentState = container.read(currentUserViewModelProvider);
      expect(currentState.isFingerprintEnabled, true);
      expect(currentState.isLoading, false);
    });
  });
  tearDown(() {
    container.dispose();
  });
}
