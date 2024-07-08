import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
import 'package:final_assignment/features/auth/presentation/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerViewModelProvider =
    StateNotifierProvider<RegisterViewModel, AuthState>((ref) {
  final navigator = ref.watch(registerNavigatorProvider);
  final authUsecase = ref.watch(authUseCaseProvider);
  return RegisterViewModel(navigator, authUsecase);
});

class RegisterViewModel extends StateNotifier<AuthState> {
  RegisterViewModel(this.navigator, this.authUseCase)
      : super(AuthState.initial());

  final RegisterViewNavigator navigator;
  final AuthUseCase authUseCase;

  void openLoginView() {
    navigator.openLoginView();
  }

  void registerUser(AuthEntity auth) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.registerUser(auth);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        showMySnackBar(message: l.error, color: Colors.red);
      },
      (r) {
        state = state.copyWith(isLoading: false);
        showMySnackBar(message: "User registered successfully");
      },
    );
  }
}
