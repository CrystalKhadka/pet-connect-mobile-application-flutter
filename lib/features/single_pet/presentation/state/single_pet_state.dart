import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';

class SinglePetState {
  final String error;
  final bool isLoading;
  final PetEntity? petEntity;
  final bool isFavorite;

  SinglePetState({
    required this.error,
    required this.isLoading,
    required this.petEntity,
    required this.isFavorite,
  });

  factory SinglePetState.initial() {
    return SinglePetState(
      error: '',
      isLoading: false,
      petEntity: null,
      isFavorite: false,
    );
  }

  SinglePetState copyWith({
    String? error,
    bool? isLoading,
    PetEntity? petEntity,
    bool? isFavorite,
  }) {
    return SinglePetState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      petEntity: petEntity ?? this.petEntity,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
