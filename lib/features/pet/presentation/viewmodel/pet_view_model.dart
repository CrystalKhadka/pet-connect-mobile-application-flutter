import 'package:final_assignment/features/pet/domain/usecases/pet_usecase.dart';
import 'package:final_assignment/features/pet/presentation/state/pet_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final petViewModelProvider = StateNotifierProvider<PetViewModel, PetState>(
  (ref) => PetViewModel(
    petUseCase: ref.read(petUseCaseProvider),
  ),
);

class PetViewModel extends StateNotifier<PetState> {
  PetViewModel({required this.petUseCase}) : super(PetState.initial()) {
    fetchPets();
  }

  final PetUseCase petUseCase;

  Future resetState() async {
    state = PetState.initial();
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
      final result = await petUseCase.pagination(page, 6);
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
    }
  }
}
