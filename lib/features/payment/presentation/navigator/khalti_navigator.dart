import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/payment/presentation/view/khalti_view.dart';

class KhaltiViewNavigator {}

mixin KhaltiViewRoute {
  void openKhaltiView(String pidx) {
    NavigateRoute.pushRoute(KhaltiView(
      pidx: pidx,
    ));
  }
}
