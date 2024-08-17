import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';

class AllChatState {
  final List<AuthEntity> users;
  final bool isLoading;
  final String? error;

  AllChatState(
      {required this.users, required this.isLoading, required this.error});

  factory AllChatState.initial() {
    return AllChatState(
      users: [],
      isLoading: false,
      error: null,
    );
  }

  AllChatState copyWith({
    List<AuthEntity>? users,
    bool? isLoading,
    String? error,
  }) {
    return AllChatState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
