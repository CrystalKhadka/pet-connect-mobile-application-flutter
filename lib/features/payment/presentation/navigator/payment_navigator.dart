import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/payment/presentation/navigator/khalti_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view/payment_view.dart';

final paymentNavigatorProvider = Provider<PaymentViewNavigator>((ref) {
  return PaymentViewNavigator();
});

class PaymentViewNavigator with KhaltiViewRoute {
  pop() {
    NavigateRoute.pop();
  }
}

mixin PaymentViewRoute {
  void openPaymentView(String id) {
    NavigateRoute.pushRoute(PaymentView(petId: id));
  }
}
