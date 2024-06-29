import 'package:final_assignment/features/settings/presentation/state/current_user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/domain/usecases/auth_use_case.dart';

final currentUserViewModelProvider =
    StateNotifierProvider<CurrentUserViewModel, CurrentUserState>((ref) {
  final authUseCase = ref.watch(authUseCaseProvider);
  return CurrentUserViewModel(authUseCase: authUseCase);
});

class CurrentUserViewModel extends StateNotifier<CurrentUserState> {
  CurrentUserViewModel({required this.authUseCase})
      : super(CurrentUserState.initial()) {
    getCurrentUser();
  }

  final AuthUseCase authUseCase;

  Future getCurrentUser() async {
    state = state.copyWith(isLoading: true);
    await authUseCase.getCurrentUser().then((data) {
      data.fold(
        (l) {
          state = state.copyWith(isLoading: false, error: l.error);
        },
        (r) {
          state = state.copyWith(isLoading: false, authEntity: r);
        },
      );
    });
  }
}
