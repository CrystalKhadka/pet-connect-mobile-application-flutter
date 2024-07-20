import 'package:final_assignment/features/pet/domain/usecases/pet_usecase.dart';
import 'package:final_assignment/features/pet/presentation/navigator/pet_view_navigator.dart';
import 'package:final_assignment/features/pet/presentation/state/pet_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final petViewModelProvider = StateNotifierProvider<PetViewModel, PetState>(
  (ref) => PetViewModel(
    petUseCase: ref.read(petUseCaseProvider),
    petViewNavigator: ref.read(petNavigatorProvider),
  ),
);

class PetViewModel extends StateNotifier<PetState> {
  PetViewModel({required this.petUseCase, required this.petViewNavigator})
      : super(PetState.initial()) {
    fetchPets(state.limit);
    fetchSpecies();
  }

  final PetUseCase petUseCase;
  final PetViewNavigator petViewNavigator;

  Future<void> resetState() async {
    state = PetState.initial();
    fetchPets(state.limit);
    fetchSpecies();
  }

  Future<void> fetchPets(int limit) async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final pets = currentState.pets;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from data source

      final result = await petUseCase.pagination(page, limit);
      result.fold(
        (failure) => state = state.copyWith(
          hasReachedMax: true,
          isLoading: false,
          error: failure.error,
        ),
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
    } else {
      state = state.copyWith(isLoading: false);
      // showMySnackBar(message: 'No more data to load.', color: Colors.red);
    }
  }

  Future<void> fetchSpecies() async {
    final result = await petUseCase.getAllSpecies();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (data) => state = state.copyWith(species: data),
    );
  }

  void openSinglePetView(String id) {
    petViewNavigator.openSinglePetView(id);
  }

  void openAdoptionForm(String id) {
    petViewNavigator.openAdoptionFormView( id);
  }
}
