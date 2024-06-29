import '../../../auth/domain/entity/auth_entity.dart';

class CurrentUserState {
  final bool isLoading;
  final AuthEntity? authEntity;
  final String? error;

  CurrentUserState(
      {required this.isLoading, required this.authEntity, required this.error});

  factory CurrentUserState.initial() {
    return CurrentUserState(isLoading: false, authEntity: null, error: null);
  }

  CurrentUserState copyWith(
      {bool? isLoading, AuthEntity? authEntity, String? error}) {
    return CurrentUserState(
        isLoading: isLoading ?? this.isLoading,
        authEntity: authEntity ?? this.authEntity,
        error: error ?? this.error);
  }
}
