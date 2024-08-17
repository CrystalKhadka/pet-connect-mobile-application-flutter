import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/favorite/presentation/view/favorite_view.dart';

class FavoriteViewNavigator {}

mixin FavoriteViewRoute {
  void openFavoriteView() {
    NavigateRoute.pushRoute(const FavoriteView());
  }
}
