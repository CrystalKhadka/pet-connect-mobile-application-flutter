import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/all_chat/presentation/view/all_chat_view.dart';
import 'package:final_assignment/features/chat/presentation/navigator/chat_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allChatNavigatorProvider = Provider((ref) => AllChatViewNavigator());

class AllChatViewNavigator with ChatViewRoute {}

mixin AllChatRoute {
  openAllChatView() {
    NavigateRoute.pushRoute(const AllChatView());
  }
}
