import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/chat/presentation/view/chat_view.dart';

class ChatViewNavigator {}

mixin ChatViewRoute {
  openChatView({String? id}) {
    NavigateRoute.pushRoute(ChatView(
      receiverId: id,
    ));
  }
}
