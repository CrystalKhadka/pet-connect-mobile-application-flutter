import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/core/networking/google/google_service.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AuthState>((ref) {
  final navigator = ref.watch(loginNavigatorProvider);
  final authUsecase = ref.watch(authUseCaseProvider);
  final gooleSignInService = ref.watch(googleSignInServiceProvider);
  return LoginViewModel(
    navigator: navigator,
    authUseCase: authUsecase,
    googleSignInService: gooleSignInService,
  );
});

class LoginViewModel extends StateNotifier<AuthState> {
  LoginViewModel(
      {required this.navigator,
      required this.authUseCase,
      required this.googleSignInService})
      : super(AuthState.initial());

  final LoginViewNavigator navigator;
  final AuthUseCase authUseCase;
  final GoogleSignInService googleSignInService;

  loginUser(String email, String password) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.loginUser(email, password);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        // showMySnackBar(message: l.error, color: Colors.red);
      },
      (r) {
        state = state.copyWith(isLoading: false);
        // showMySnackBar(message: "User logged in successfully");
        navigator.openDashboardView();
      },
    );
  }

  Future<void> fingerPrintLogin() async {
    final localAuth = LocalAuthentication();

    bool authenticated = false;
    try {
      authenticated = await localAuth.authenticate(
        localizedReason: 'Authenticate to enable fingerprint',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );
    } catch (e) {
      showMySnackBar(
          message: 'Fingerprint authentication failed', color: Colors.red);
    }

    if (authenticated) {
      authUseCase.fingerPrintLogin().then((data) {
        data.fold(
          (l) {
            showMySnackBar(message: l.error, color: Colors.red);
          },
          (r) {
            showMySnackBar(message: "User logged in successfully");
            navigator.openDashboardView();
          },
        );
      });
    } else {
      showMySnackBar(
          message: 'Fingerprint authentication failed', color: Colors.red);
    }
  }

  getUserByGoogle() async {
    state = state.copyWith(isLoading: true);
    final google = await googleSignInService.signInWithGoogle();
    if (google != null) {
      final token = google['idToken'];
      final user = await authUseCase.getUserByGoogle(token);
      user.fold((l) {
        state = state.copyWith(isLoading: false, error: l.error);
      }, (r) {
        if (r.email!.isEmpty) {
          googleLogin(token: token, password: '12345678');
        } else {
          googleLogin(token: token);
        }
        state = state.copyWith(isLoading: false);
      });
    } else {
      state = state.copyWith(isLoading: false);
    }
  }

  googleLogin({required String token, String? password}) async {
    state = state.copyWith(isLoading: true);
    final data = await authUseCase.googleLogin(token, password);
    data.fold((l) {
      state = state.copyWith(isLoading: false, error: l.error);
      showMySnackBar(message: l.error);
    }, (r) {
      state = state.copyWith(isLoading: false);
      openDashboardView();
    });
  }

  void openRegisterView() {
    navigator.openRegisterView();
  }

  void openDashboardView() {
    navigator.openDashboardView();
  }

  void openForgotPasswordView() {
    navigator.openForgotPasswordView();
  }
}
