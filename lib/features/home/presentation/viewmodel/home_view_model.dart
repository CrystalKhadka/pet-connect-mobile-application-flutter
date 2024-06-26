import 'package:final_assignment/features/home/presentation/navigator/dashboard_navigator.dart';
import 'package:final_assignment/features/home/presentation/state/home_state.dart';
import 'package:final_assignment/features/pet/domain/usecases/pet_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(
    navigator: ref.watch(dashboardNavigatorProvider),
    petUseCase: ref.watch(petUseCaseProvider),
  ),
);

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel({
    required this.navigator,
    required this.petUseCase,
  }) : super(HomeState.initial()) {
    fetchPets();
  }

  final DashboardViewNavigator navigator;
  final PetUseCase petUseCase;

  void openLoginView() {
    navigator.openLoginView();
  }

  Future resetState() async {
    state = HomeState.initial();
    fetchPets();
  }

  Future fetchPets() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final pets = currentState.pets;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from data source
      final result = await petUseCase.pagination(page, 2);
      result.fold(
        (failure) => state = state.copyWith(
            hasReachedMax: true,
            isLoading: false,
            isError: true,
            errorMessage: failure.error),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            state = state.copyWith(
              pets: [...pets, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    }
  }
}
