import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/core/common/my_yes_no_dialog.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/home/presentation/navigator/dashboard_navigator.dart';
import 'package:final_assignment/features/pet/domain/usecases/pet_usecase.dart';
import 'package:final_assignment/features/pet/presentation/widgets/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pet/presentation/state/pet_state.dart';

// Provider
final homeViewModelProvider = StateNotifierProvider<HomeViewModel, PetState>(
  (ref) => HomeViewModel(
    navigator: ref.watch(dashboardNavigatorProvider),
    petUseCase: ref.watch(petUseCaseProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
  ),
);

class HomeViewModel extends StateNotifier<PetState> {
  HomeViewModel({
    required this.navigator,
    required this.petUseCase,
    required this.userSharedPrefs,
  }) : super(PetState.initial()) {
    fetchPets();
    fetchSpecies();
  }

  final DashboardViewNavigator navigator;
  final PetUseCase petUseCase;
  final UserSharedPrefs userSharedPrefs;

  void openLoginView() {
    navigator.openLoginView();
  }

  Future resetState() async {
    state = PetState.initial();
    fetchPets();
    fetchSpecies();
  }

  Future fetchPets() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final pets = currentState.pets;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from data source
      final limit = DeviceInfo.isTabletDevice() ? 6 : 3;
      final result = await petUseCase.pagination(page, limit);
      result.fold(
        (failure) {
          state = state.copyWith(
            hasReachedMax: true,
            isLoading: false,
            error: failure.error,
          );
        },
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
    } else {
      state = state.copyWith(isLoading: false);
      showMySnackBar(message: 'No more data to load', color: Colors.red);
    }
  }

  Future fetchSpecies() async {
    final result = await petUseCase.getAllSpecies();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (data) => state = state.copyWith(species: data),
    );
  }

  Future logout() async {
    final accept = myYesNoDialog(title: 'Are you sure you want to logout?');
    if (accept) {
      final result = await userSharedPrefs.removeUserToken();
      result.fold(
        (failure) => state = state.copyWith(
          isLoading: false,
          error: failure.error,
        ),
        (data) => openLoginView(),
      );
    }
  }
}
