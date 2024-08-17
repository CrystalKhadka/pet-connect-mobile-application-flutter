import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:final_assignment/features/forgot_password/presentation/state/forgot_password_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordViewModelProvider =
    StateNotifierProvider<ForgotPasswordViewModel, ForgotPasswordState>((ref) {
  return ForgotPasswordViewModel(
    authUseCase: ref.watch(authUseCaseProvider),
  );
});

class ForgotPasswordViewModel extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordViewModel({
    required this.authUseCase,
  }) : super(ForgotPasswordState.initial());

  final AuthUseCase authUseCase;

  changeMethod(String method) {
    state = state.copyWith(method: method);
  }

  send(String text) async {
    state = state.copyWith(isLoading: true);

    final method = state.method;

    if (method == 'email') {
      var data = await authUseCase.sendEmail(text);
      data.fold(
        (l) {
          state = state.copyWith(isLoading: false, error: l.error);
        },
        (r) {
          state = state.copyWith(isLoading: false, isSent: true);
        },
      );
    } else {
      var data = await authUseCase.sendOtp(text);
      data.fold(
        (l) {
          state = state.copyWith(isLoading: false, error: l.error);
        },
        (r) {
          state = state.copyWith(isLoading: false, isSent: true);
        },
      );
    }
  }

  verifyOtp(String otp, String phone, String password) async {
    state = state.copyWith(isLoading: true);

    var data = await authUseCase.resetPass(
      phone: phone,
      password: password,
      otp: otp,
    );
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(isLoading: false, isSent: false);

        showMySnackBar(message: 'Password Changed Successfully');
      },
    );
  }
}
