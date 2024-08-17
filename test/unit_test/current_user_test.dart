import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:final_assignment/features/profile/presentation/navigator/profile_navigator.dart';
import 'package:final_assignment/features/profile/presentation/viewmodel/current_user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'current_user_test_data/current_user_test_data.dart';
import 'login_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<ProfileViewNavigator>(),
])
void main() {
  late AuthUseCase mockAuthUseCase;
  late ProviderContainer container;
  late ProfileViewNavigator mockProfileNavigator;

  setUp(
    () {
      mockAuthUseCase = MockAuthUseCase();
      mockProfileNavigator = ProfileViewNavigator();
      container = ProviderContainer(
        overrides: [
          currentUserViewModelProvider.overrideWith(
            (ref) => CurrentUserViewModel(
                authUseCase: mockAuthUseCase,
                profileNavigator: mockProfileNavigator),
          ),
        ],
      );
    },
  );

  group('Current user view model test', () {
    // test('Get current user test', () async {
    //   // Arrange
    //   when(mockAuthUseCase.getCurrentUser()).thenAnswer(
    //       (_) => Future.value(Right(CurrentUserTestData.getAuthEntity())));

    //   when(mockAuthUseCase.getFingerPrintId()).thenAnswer(
    //     (_) => Future.value(
    //       Right(CurrentUserTestData.getAuthEntity().id ?? ''),
    //     ),
    //   );

    //   // Act
    //   await container
    //       .read(currentUserViewModelProvider.notifier)
    //       .getCurrentUser();

    //   // Assert
    //   final currentState = container.read(currentUserViewModelProvider);
    //   expect(currentState.authEntity, CurrentUserTestData.getAuthEntity());
    //   expect(currentState.isLoading, false);
    // });

    test('getCurrentUser succeeds and updates state correctly', () async {
      // Mock data

      // Stub authUseCase.getCurrentUser()
      when(mockAuthUseCase.getCurrentUser()).thenAnswer(
          (_) => Future.value(Right(CurrentUserTestData.getAuthEntity())));
      // Stub userSharedPrefs.checkId() to return Right with matching userIddev dep

      // act
      await container
          .read(currentUserViewModelProvider.notifier)
          .getCurrentUser();
      // Execute getCurrentUse
      final profileState = container.read(currentUserViewModelProvider);
      // Verify state updates
      expect(profileState.isLoading, false);
      expect(profileState.error, isNull);
      expect(profileState.authEntity, CurrentUserTestData.getAuthEntity());
      // Verify interactions
      verify(mockAuthUseCase.getCurrentUser()).called(2);
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
