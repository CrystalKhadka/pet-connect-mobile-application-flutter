import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';

class AdoptionState {
  final String? error;
  final bool isLoading;
  final PetEntity? petEntity;

  AdoptionState({
    required this.error,
    required this.isLoading,
    required this.petEntity,
  });

  factory AdoptionState.initial() {
    return AdoptionState(
      error: '',
      isLoading: false,
      petEntity: null,
    );
  }

  AdoptionState copyWith({
    String? error,
    bool? isLoading,
    PetEntity? petEntity,
  }) {
    return AdoptionState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      petEntity: petEntity ?? this.petEntity,
    );
  }
}
