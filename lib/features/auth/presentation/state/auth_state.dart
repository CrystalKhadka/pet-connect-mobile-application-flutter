class AuthState {
  final bool isLoading;
  final bool isObscure;
  final String? error;
  final bool termsAndConditions;
  final String gender;

  AuthState({
    required this.termsAndConditions,
    required this.isLoading,
    required this.isObscure,
    this.error,
    required this.gender,
  });

  factory AuthState.initial() => AuthState(
        isLoading: false,
        isObscure: true,
        error: null,
        termsAndConditions: false,
        gender: 'male',
      );

  AuthState copyWith({
    bool? isLoading,
    bool? isObscure,
    String? error,
    bool? termsAndConditions,
    String? gender,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isObscure: isObscure ?? this.isObscure,
      error: error ?? this.error,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      gender: gender ?? this.gender,
    );
  }
}
