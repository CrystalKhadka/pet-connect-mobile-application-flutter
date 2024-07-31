import 'dart:io';

import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:final_assignment/features/edit_profile/presentation/state/edit_profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/domain/entity/auth_entity.dart';

final editProfileViewModelProvider =
    StateNotifierProvider<EditProfileViewModel, EditProfileState>(
  (ref) {
    return EditProfileViewModel(
      ref.read(authUseCaseProvider),
    );
  },
);

class EditProfileViewModel extends StateNotifier<EditProfileState> {
  EditProfileViewModel(this.authUseCase) : super(EditProfileState.initial()) {
    fetchCurrentUser();
  }

  final AuthUseCase authUseCase;

  Future<void> fetchCurrentUser() async {
    state = state.copyWith(isLoading: true);
    final data = await authUseCase.getCurrentUser();

    data.fold((l) {
      state = state.copyWith(
        isLoading: false,
        error: l.error,
      );
    }, (r) {
      state = state.copyWith(
        isLoading: false,
        authEntity: r,
      );
    });
  }

  Future<void> uploadImage(File file) async {
    state = state.copyWith(isLoading: true);
    final data = await authUseCase.uploadImage(file);
    data.fold((l) {
      state = state.copyWith(
        isLoading: false,
        error: l.error,
      );
    }, (r) {
      state = state.copyWith(
        isLoading: false,
        imageName: r,
      );
    });
  }

  Future<void> updateUser(AuthEntity user) async {
    state = state.copyWith(isLoading: true);
    final data = await authUseCase.updateUser(user);
    data.fold((l) {
      state = state.copyWith(
        isLoading: false,
        error: l.error,
      );
    }, (r) {
      state = state.copyWith(
        isLoading: false,
      );
      fetchCurrentUser();
    });
  }
}
