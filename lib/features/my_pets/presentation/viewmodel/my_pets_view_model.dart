import 'package:final_assignment/features/adoption/domain/usecases/adoption_usecase.dart';
import 'package:final_assignment/features/my_pets/presentation/navigator/my_pets_navigator.dart';
import 'package:final_assignment/features/my_pets/presentation/state/my_pets_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myPetsViewModelProvider =
    StateNotifierProvider<MyPetsViewModel, MyPetsState>(
  (ref) => MyPetsViewModel(
    adoptionUsecase: ref.watch(adoptionUseCaseProvider),
    navigator: ref.watch(myPetsViewNavigatorProvider),
  ),
);

class MyPetsViewModel extends StateNotifier<MyPetsState> {
  MyPetsViewModel({required this.adoptionUsecase, required this.navigator})
      : super(MyPetsState.initial()) {
    getMyPets();
  }

  final AdoptionUsecase adoptionUsecase;
  final MyPetsViewNavigator navigator;

  getMyPets() async {
    state = state.copyWith(isLoading: true);
    final result = await adoptionUsecase.getAdoptionsByUser();
    print(result);
    result.fold(
      (l) => state = state.copyWith(error: l.error, isLoading: false),
      (r) => state = state.copyWith(adoptions: r, isLoading: false),
    );
  }

  openSinglePetView(String id) {
    navigator.openSinglePetView(id);
  }
}
