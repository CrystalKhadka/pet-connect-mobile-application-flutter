import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';

class SinglePetState {
  final String error;
  final bool isLoading;
  final PetEntity? petEntity;

  SinglePetState({
    required this.error,
    required this.isLoading,
    required this.petEntity,
  });

  factory SinglePetState.initial() {
    return SinglePetState(
      error: '',
      isLoading: false,
      petEntity: null,
    );
  }

  SinglePetState copyWith({
    String? error,
    bool? isLoading,
    PetEntity? petEntity,
  }) {
    return SinglePetState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      petEntity: petEntity ?? this.petEntity,
    );
  }
}
