import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/adoption/presentation/view/adoption_form_view.dart';

class AdoptionFormViewNavigator {}

mixin AdoptionFormRoute {
  openAdoptionFormView() {
    NavigateRoute.pushRoute(const AdoptionFormView());
  }
}
