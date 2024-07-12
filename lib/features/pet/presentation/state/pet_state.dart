import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';

class PetState {
  final bool isLoading;
  final String? error;
  final List<PetEntity> pets;
  final bool hasReachedMax;
  final int page;
  final List<String> species;
  final int limit;

  factory PetState.initial() {
    return PetState(
      isLoading: false,
      error: null,
      pets: [],
      page: 0,
      hasReachedMax: false,
      species: [],
      limit: 6,
    );
  }

  PetState({
    required this.isLoading,
    required this.error,
    required this.pets,
    required this.page,
    required this.hasReachedMax,
    required this.species,
    required this.limit,
  });

  PetState copyWith({
    bool? isLoading,
    String? error,
    List<PetEntity>? pets,
    int? page,
    bool? hasReachedMax,
    List<String>? species,
    int? limit,
  }) {
    return PetState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      pets: pets ?? this.pets,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      species: species ?? this.species,
      limit: limit ?? this.limit,
    );
  }
}
