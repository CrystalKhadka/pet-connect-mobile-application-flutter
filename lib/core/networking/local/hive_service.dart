import 'package:final_assignment/app/constants/hive_table_constant.dart';
import 'package:final_assignment/features/auth/data/model/auth_hive_model.dart';
import 'package:final_assignment/features/pet/data/model/pet_hive_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    // Initialize Hive

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(PetHiveModelAdapter());
  }

  // ===============User Query================

  // Register Query
  Future<void> registerUser(AuthHiveModel user) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBoxName);
    await box.put(user.userId, user);
  }

  Future<AuthHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBoxName);
    var user = box.values.firstWhere(
        (element) => element.email == email && element.password == password,
        orElse: () => AuthHiveModel.empty());
    return user;
  }

  Future<void> logout() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBoxName);
    await box.clear();
  }

  Future<AuthHiveModel> getUserByEmail(String email) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBoxName);
    var user = box.values.firstWhere(
      (element) => element.email == email,
      orElse: () => AuthHiveModel.empty(),
    );
    return user;
  }

// ===============Pet Query================
  Future<List<PetHiveModel>> getAllPets() async {
    var box = await Hive.openBox<PetHiveModel>(HiveTableConstant.petBoxName);
    return box.values.toList();
  }

  static Future<bool> saveAllPets(List<PetHiveModel> pets) async {
    var box = await Hive.openBox<PetHiveModel>(HiveTableConstant.petBoxName);
    await box.clear();
    await box.addAll(pets);
    return true;
  }
}
