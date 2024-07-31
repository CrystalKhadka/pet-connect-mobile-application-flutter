import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final socketServiceProvider = Provider<SocketService>((ref) {
  return SocketService(
    ref.watch(authUseCaseProvider),
  );
});

class SocketService {
  static IO.Socket? _socket;
  final AuthUseCase authUseCase;

  SocketService(this.authUseCase);

  static Future<IO.Socket> initSocket() async {
    if (_socket != null && _socket!.connected) {
      return _socket!;
    }

    final UserSharedPrefs userSharedPrefs = UserSharedPrefs();
    String? token;
    final data = await userSharedPrefs.getUserToken();
    data.fold(
      (l) => token=null,
      (r) => token = r,
    );

    String url =
        'http://192.168.137.1:5000'; // Replace with your actual server URL

    _socket = IO.io(
      url,
      IO.OptionBuilder()
          .setTransports(['websocket']).setQuery({'id': token ?? ''}).build(),
    );

    _socket!.connect();

    return _socket!;
  }

  static IO.Socket get socket {
    if (_socket == null) {
      throw Exception("Socket not initialized. Call initSocket() first.");
    }
    return _socket!;
  }
}
