import 'package:final_assignment/app/navigator/navigator.dart';

import '../view/payment_view.dart';

class PaymentViewNavigator {
  pop() {
    NavigateRoute.pop();
  }
}

mixin PaymentViewRoute {
  void openPaymentView(String id) {
    NavigateRoute.pushRoute(PaymentView(petId: id));
  }
}
