import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_screen/dashboard_view.dart';

class DashboardViewNavigator {}

mixin DashboardViewRoute {
  openDashboardView() {
    NavigateRoute.popAndPushRoute(const DashboardView());
  }
}
