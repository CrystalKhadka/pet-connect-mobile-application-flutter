import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';

class PetState {
  final bool isLoading;
  final String error;
  final List<PetEntity> pets;
  final bool hasReachedMax;
  final int page;

  factory PetState.initial() {
    return PetState(
      isLoading: false,
      error: '',
      pets: [],
      page: 0,
      hasReachedMax: false,
    );
  }

  PetState({
    required this.isLoading,
    required this.error,
    required this.pets,
    required this.page,
    required this.hasReachedMax,
  });

  PetState copyWith({
    bool? isLoading,
    String? error,
    List<PetEntity>? pets,
    int? page,
    bool? hasReachedMax,
  }) {
    return PetState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      pets: pets ?? this.pets,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
