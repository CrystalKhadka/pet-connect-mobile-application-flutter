import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:final_assignment/features/splash/presentation/navigator/splash_navigator.dart';
import 'package:final_assignment/features/splash/presentation/viewmodel/splash_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_test.mocks.dart';
import 'splash_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SplashViewNavigator>()])
void main() {
  late SplashViewNavigator mockSplashViewNavigator;
  late AuthUseCase mockAuthUseCase;

  late ProviderContainer container;

  setUp(() {
    mockSplashViewNavigator = MockSplashViewNavigator();
    mockAuthUseCase = MockAuthUseCase();

    container = ProviderContainer(overrides: [
      splashViewModelProvider.overrideWith(
        (ref) => SplashViewModel(
          mockSplashViewNavigator,
          mockAuthUseCase,
        ),
      ),
    ]);
  });

  test('open dashboard view test', () async {
    // Arrange
    when(mockAuthUseCase.verifyUser())
        .thenAnswer((_) async => const Right(true));

    // Act
    await container.read(splashViewModelProvider.notifier).openView();

    // Assert
    verify(mockSplashViewNavigator.openDashboardView()).called(1);
  });
  test('open login view test', () async {
    // Arrange
    when(mockAuthUseCase.verifyUser()).thenAnswer(
      (_) async => Left(
        Failure(error: 'Invalid'),
      ),
    );

    // Act
    await container.read(splashViewModelProvider.notifier).openView();

    // Assert
    verify(mockSplashViewNavigator.openLoginView()).called(1);
  });

  tearDown(() {
    container.dispose();
  });
}
