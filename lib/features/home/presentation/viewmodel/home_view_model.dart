import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/core/common/widgets/my_yes_no_dialog.dart';
import 'package:final_assignment/core/networking/socket/socket_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:final_assignment/features/home/presentation/navigator/dashboard_navigator.dart';
import 'package:final_assignment/features/home/presentation/state/home_state.dart';
import 'package:final_assignment/features/notification/domain/usecases/notification_usecase.dart';
import 'package:final_assignment/features/pet/domain/usecases/pet_usecase.dart';
import 'package:final_assignment/features/pet/presentation/widgets/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/networking/google/google_service.dart';
import '../../../../core/networking/local_notification/notification_service.dart';

// Provider
final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(
    navigator: ref.watch(dashboardNavigatorProvider),
    petUseCase: ref.watch(petUseCaseProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
    authUseCase: ref.watch(authUseCaseProvider),
    googleSignInService: ref.watch(googleSignInServiceProvider),
    notificationUsecase: ref.watch(notificationUsecaseProvider),
  ),
);

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel({
    required this.navigator,
    required this.petUseCase,
    required this.userSharedPrefs,
    required this.notificationUsecase,
    required this.authUseCase,
    required this.googleSignInService,
  }) : super(HomeState.initial()) {
    // Show snackbar on successful connection

    // socket.emit('test', 'Connected to server');
    //
    // socket.on('sendTest', (data) {
    //   showMySnackBar(message: data.toString());
    // });
    initSocket();
    fetchPets();
    fetchSpecies();
  }

  final DashboardViewNavigator navigator;
  final PetUseCase petUseCase;
  final UserSharedPrefs userSharedPrefs;
  final AuthUseCase authUseCase;
  final GoogleSignInService googleSignInService;
  final NotificationUsecase notificationUsecase;

  final socket = SocketService.socket;

  void openLoginView() {
    navigator.openLoginView();
  }

  void openChatView() {
    navigator.openChatView();
  }

  initSocket() async {
    state = state.copyWith(isLoading: true);
    newUser();
    socket.emit('test', 'Connected to mobile');

    socket.on('receiveNotification', receiveNotification);

    socket.on('disconnect', (data) {
      // showMySnackBar(message: 'Disconnected from server');
      //   try to reconnect new user
      newUser();
    });
  }

  receiveNotification(dynamic data) async {
    NotificationService().showNotification(data);
    await fetchNotificationCount();
  }

  newUser() async {
    String? userId;
    final data = await authUseCase.getCurrentUser();
    data.fold((l) {
      showMySnackBar(message: l.error);
    }, (r) {
      userId = r.id;
    });

    socket.emit("newUser", userId ?? "Guest");
    state = state.copyWith(isLoading: false);
  }

  Future resetState() async {
    state = HomeState.initial();
    initSocket();
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
      final result = await petUseCase.pagination(page, limit, '', 'all');
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
    final accept =
        await myYesNoDialog(title: 'Are you sure you want to logout?');

    if (accept) {
      state = state.copyWith(isLoading: true);
      googleSignInService.signOutGoogle();
      final result = await userSharedPrefs.removeUserToken();

      result.fold(
          (failure) => state = state.copyWith(
                isLoading: false,
                error: failure.error,
              ), (data) {
        state = state.copyWith(isLoading: false);
        navigator.openLoginView();
      });
    }
  }

  fetchNotificationCount() async {
    final result = await notificationUsecase.getNotificationsCount();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (data) => state = state.copyWith(notificationCount: data),
    );
  }
}
