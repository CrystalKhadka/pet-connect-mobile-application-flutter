import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/core/common/my_yes_no_dialog.dart';
import 'package:final_assignment/features/settings/presentation/state/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

import '../../../auth/domain/usecases/auth_use_case.dart';

final currentUserViewModelProvider =
    StateNotifierProvider<CurrentUserViewModel, CurrentUserState>((ref) {
  final authUseCase = ref.watch(authUseCaseProvider);
  return CurrentUserViewModel(authUseCase: authUseCase);
});

class CurrentUserViewModel extends StateNotifier<CurrentUserState> {
  final AuthUseCase authUseCase;
  late LocalAuthentication _localAuth;
  late FlutterSecureStorage _secureStorage;

  CurrentUserViewModel({required this.authUseCase})
      : super(CurrentUserState.initial()) {
    initialize();
  }

  Future<void> initialize() async {
    _localAuth = LocalAuthentication();
    _secureStorage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    await getCurrentUser();
    await loadFingerprintEnabled(); // Load fingerprint status from secure storage
  }

  AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }

  Future<void> getCurrentUser() async {
    try {
      state = state.copyWith(isLoading: true);
      final data = await authUseCase.getCurrentUser();
      data.fold(
        (l) {
          state = state.copyWith(isLoading: false, error: l.error);
        },
        (r) {
          state = state.copyWith(isLoading: false, authEntity: r);
        },
      );
    } catch (e) {
      state = state.copyWith(
          isLoading: false, error: 'Failed to fetch current user.');
      print('Error fetching current user: $e');
    }
  }

  Future<void> enableFingerprint() async {
    if (state.isFingerprintEnabled) {
      bool result = await myYesNoDialog(
        title: 'Are you sure? Do you want to disable fingerprint login?',
      );
      if (result) {
        state = state.copyWith(isFingerprintEnabled: false);
        await saveFingerprintEnabled(
            false); // Save fingerprint status to secure storage
        showMySnackBar(message: 'Fingerprint disabled', color: Colors.green);
      }
    } else {
      bool authenticated = false;
      try {
        authenticated = await _localAuth.authenticate(
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
        state = state.copyWith(isFingerprintEnabled: true);
        await saveFingerprintEnabled(
            true); // Save fingerprint status to secure storage
        showMySnackBar(message: 'Fingerprint enabled', color: Colors.green);
      }
    }
  }

  Future<void> loadFingerprintEnabled() async {
    try {
      final isEnabled =
          await _secureStorage.read(key: 'fingerprint_enabled') == 'true';
      state = state.copyWith(isFingerprintEnabled: isEnabled);
    } catch (e) {
      print('Error loading fingerprint status from secure storage: $e');
      showMySnackBar(
          message: 'Failed to load fingerprint status', color: Colors.red);
    }
  }

  Future<void> saveFingerprintEnabled(bool isEnabled) async {
    try {
      await _secureStorage.write(
          key: 'fingerprint_enabled', value: isEnabled.toString());
    } catch (e) {
      print('Error saving fingerprint status to secure storage: $e');
      showMySnackBar(
          message: 'Failed to save fingerprint status', color: Colors.red);
    }
  }
}
