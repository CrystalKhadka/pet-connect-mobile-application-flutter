import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/core/common/my_yes_no_dialog.dart';
import 'package:final_assignment/features/profile/presentation/navigator/profile_navigator.dart';
import 'package:final_assignment/features/profile/presentation/state/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../../../auth/domain/usecases/auth_use_case.dart';

final currentUserViewModelProvider =
    StateNotifierProvider<CurrentUserViewModel, CurrentUserState>(
        (ref) => CurrentUserViewModel(
              authUseCase: ref.read(authUseCaseProvider),
              profileNavigator: ref.read(profileNavigatorProvider),
            ));

class CurrentUserViewModel extends StateNotifier<CurrentUserState> {
  final AuthUseCase authUseCase;
  final ProfileViewNavigator profileNavigator;

  CurrentUserViewModel({
    required this.authUseCase,
    required this.profileNavigator,
  }) : super(CurrentUserState.initial()) {
    getCurrentUser();
    checkFingerprint();
  }

  Future<void> initialize() async {
    await getCurrentUser();
    await checkFingerprint();
  }

  openFavoriteView() {
    profileNavigator.openFavoriteView();
  }

  openEditProfile() {
    profileNavigator.openEditProfileView();
  }

  openMyPetsView() {
    profileNavigator.openMyPetsView();
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
    }
  }

  Future<void> enableFingerprint() async {
    state = state.copyWith(isLoading: true);
    final localAuth = LocalAuthentication();
    if (state.isFingerprintEnabled) {
      bool result = await myYesNoDialog(
        title: 'Are you sure? Do you want to disable fingerprint login?',
      );
      if (result) {
        final data = await authUseCase.saveFingerPrintId('');
        data.fold((l) {
          showMySnackBar(
              message: 'Failed to disable fingerprint', color: Colors.red);
        }, (r) {
          state = state.copyWith(isFingerprintEnabled: false, isLoading: false);
          showMySnackBar(message: 'Fingerprint disabled', color: Colors.red);
        });
      } else {
        state = state.copyWith(isLoading: false);
      }
    } else {
      bool result = await myYesNoDialog(
        title: 'Are you sure? Do you want to enable fingerprint login?',
      );
      if (result) {
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
          authenticated = false;
          showMySnackBar(
              message: 'Fingerprint authentication failed', color: Colors.red);
        }

        if (authenticated) {
          final data =
              await authUseCase.saveFingerPrintId(state.authEntity?.id ?? '');
          data.fold((l) {
            state = state.copyWith(isLoading: false, error: l.error);
            showMySnackBar(
                message: 'Failed to enable fingerprint', color: Colors.red);
          }, (r) {
            showMySnackBar(message: 'Fingerprint enabled', color: Colors.green);
            state =
                state.copyWith(isFingerprintEnabled: true, isLoading: false);
          });
        } else {
          await authUseCase.saveFingerPrintId('');
          state = state.copyWith(isLoading: false);
        }
      } else {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  Future<void> checkFingerprint() async {
    state = state.copyWith(isLoading: true);
    final currentUserId = state.authEntity!.id;
    final result = await authUseCase.getFingerPrintId();
    result.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        if (r == currentUserId) {
          state = state.copyWith(isFingerprintEnabled: true, isLoading: false);
        } else {
          state = state.copyWith(
            isLoading: false,
            isFingerprintEnabled: false,
          );
        }
      },
    );
  }
}
