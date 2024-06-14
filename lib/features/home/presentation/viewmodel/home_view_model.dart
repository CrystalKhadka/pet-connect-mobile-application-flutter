import 'package:final_assignment/features/home/presentation/navigator/dashboard_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
final homeViewModelProvider = StateNotifierProvider<HomeViewModel, void>(
  (ref) => HomeViewModel(ref.read(dashboardNavigatorProvider)),
);

class HomeViewModel extends StateNotifier<void> {
  HomeViewModel(this.navigator) : super(null);

  final DashboardViewNavigator navigator;
  void openLoginView() {
    navigator.openLoginView();
  }
}
