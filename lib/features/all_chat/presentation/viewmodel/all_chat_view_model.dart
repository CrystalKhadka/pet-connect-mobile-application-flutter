import 'package:final_assignment/features/all_chat/presentation/navigator/all_chat_navigator.dart';
import 'package:final_assignment/features/all_chat/presentation/state/all_chat_state.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allChatViewModelProvider =
    StateNotifierProvider<AllChatViewModel, AllChatState>((ref) {
  return AllChatViewModel(
      ref.watch(authUseCaseProvider), ref.watch(allChatNavigatorProvider));
});

class AllChatViewModel extends StateNotifier<AllChatState> {
  AllChatViewModel(this._authUseCase, this._navigator)
      : super(AllChatState.initial()) {
    getAllUsers();
  }

  final AuthUseCase _authUseCase;
  final AllChatViewNavigator _navigator;

  void getAllUsers() async {
    state = state.copyWith(isLoading: true);
    final result = await _authUseCase.getAllUsers();

    if (result == null) {
      state = state.copyWith(isLoading: false, error: 'No data found');
      return;
    }

    result.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, users: r),
    );
  }

  void openChatView(String id) {
    _navigator.openChatView(id: id);
  }
}
