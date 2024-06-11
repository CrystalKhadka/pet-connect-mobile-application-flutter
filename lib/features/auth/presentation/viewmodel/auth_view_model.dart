import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:final_assignment/features/auth/presentation/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(ref.watch(authUseCaseProvider));
});

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this.authUseCase) : super(AuthState.initial());

  final AuthUseCase authUseCase;

  void registerUser(AuthEntity auth) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.registerUser(auth);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(isLoading: false);
      },
    );
  }

  void obscurePassword() {
    state = state.copyWith(isObscure: !state.isObscure);
  }

  void termsAndConditions() {
    state = state.copyWith(termsAndConditions: !state.termsAndConditions);
  }

  void gender(String value) {
    state = state.copyWith(gender: value);
  }
}
