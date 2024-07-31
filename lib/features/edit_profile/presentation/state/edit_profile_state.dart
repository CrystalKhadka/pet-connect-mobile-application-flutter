import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';

class EditProfileState {
  final String? error;
  final AuthEntity? authEntity;
  final String? imageName;
  final bool isLoading;

  EditProfileState(
      {required this.error,
      required this.authEntity,
      required this.imageName,
      required this.isLoading});

  factory EditProfileState.initial() {
    return EditProfileState(
      error: null,
      authEntity: null,
      imageName: null,
      isLoading: false,
    );
  }

  EditProfileState copyWith(
      {String? error,
      String? imageName,
      AuthEntity? authEntity,
      bool? isLoading}) {
    return EditProfileState(
      error: error ?? this.error,
      authEntity: authEntity ?? this.authEntity,
      imageName: imageName ?? this.imageName,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
