import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:final_assignment/features/splash/presentation/navigator/splash_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, void>((ref) {
  final navigator = ref.read(splashViewNavigatorProvider);
  final authUseCase = ref.read(authUseCaseProvider);
  return SplashViewModel(
    navigator,
    authUseCase,
  );
});

class SplashViewModel extends StateNotifier<void> {
  SplashViewModel(this.navigator, this.authUseCase) : super(null);

  final SplashViewNavigator navigator;
  final AuthUseCase authUseCase;

  void openLoginView() {
    navigator.openLoginView();
  }

  void openDashboardView() {
    navigator.openDashboardView();
  }

  Future<void> openView() async {
    final result = await authUseCase.verifyUser();
    result.fold(
      (failure) => openLoginView(),
      (data) => openDashboardView(),
    );
  }
}
