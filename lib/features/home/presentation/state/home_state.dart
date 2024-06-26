import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';

class HomeState {
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  final List<PetEntity> pets;
  final bool hasReachedMax;
  final int page;

  factory HomeState.initial() {
    return HomeState(
      isLoading: false,
      isError: false,
      errorMessage: '',
      pets: [],
      page: 0,
      hasReachedMax: false,
    );
  }

  HomeState({
    required this.isLoading,
    required this.isError,
    required this.errorMessage,
    required this.pets,
    required this.page,
    required this.hasReachedMax,
  });

  HomeState copyWith({
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    List<PetEntity>? pets,
    int? page,
    bool? hasReachedMax,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      pets: pets ?? this.pets,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
