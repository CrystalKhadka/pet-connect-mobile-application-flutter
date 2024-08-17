import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/features/adoption/domain/entity/adoption_entity.dart';
import 'package:final_assignment/features/adoption/domain/entity/form_entity.dart';
import 'package:final_assignment/features/adoption/domain/usecases/adoption_usecase.dart';
import 'package:final_assignment/features/adoption/presentation/state/adoption_state.dart';
import 'package:final_assignment/features/pet/domain/usecases/pet_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adoptionViewModelProvider =
    StateNotifierProvider<AdoptionViewModel, AdoptionState>(
  (ref) => AdoptionViewModel(
    ref.read(adoptionUseCaseProvider),
    ref.read(petUseCaseProvider),
  ),
);

class AdoptionViewModel extends StateNotifier<AdoptionState> {
  AdoptionViewModel(this._adoptionUseCase, this._petUseCase)
      : super(AdoptionState.initial());

  final AdoptionUsecase _adoptionUseCase;
  final PetUseCase _petUseCase;

  setPet(String pet) {
    state = state.copyWith(isLoading: true);
    _petUseCase.getPetById(pet).then((result) {
      result.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.error);
        },
        (pet) {
          state = state.copyWith(isLoading: false, petEntity: pet);
        },
      );
    });
  }

  void submitForm(FormEntity form) {
    state = state.copyWith(isLoading: true);
    final pet = state.petEntity;

    final adoption = AdoptionEntity(
      form: form,
      pet: pet,
      formReceiver: pet!.createdBy!,
    );

    _adoptionUseCase.addAdoptionForm(adoption).then((result) {
      result.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.error);
          showMySnackBar(message: failure.error);
        },
        (success) {
          state = state.copyWith(isLoading: false);
        },
      );
    });
  }
}
