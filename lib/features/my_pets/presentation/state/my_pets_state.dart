import '../../../adoption/domain/entity/adoption_entity.dart';

class MyPetsState {
  final String? error;
  final bool isLoading;
  final int page;
  final List<AdoptionEntity> adoptions;

  MyPetsState({
    required this.error,
    required this.isLoading,
    required this.page,
    required this.adoptions,
  });

  factory MyPetsState.initial() {
    return MyPetsState(
      error: null,
      isLoading: false,
      page: 0,
      adoptions: [],
    );
  }

  MyPetsState copyWith({
    String? error,
    bool? isLoading,
    int? page,
    List<AdoptionEntity>? adoptions,
  }) {
    return MyPetsState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      adoptions: adoptions ?? this.adoptions,
    );
  }
}
