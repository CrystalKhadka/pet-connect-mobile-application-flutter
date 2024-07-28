import 'package:final_assignment/core/networking/local/hive_service.dart';
import 'package:final_assignment/core/networking/socket/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();
  await SocketService.initSocket();
  runApp(const ProviderScope(child: App()));
}
