import 'package:final_assignment/features/settings/presentation/viewmodel/current_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/profile_menu_item.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final currentUserState = ref.watch(currentUserViewModelProvider);
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                  child: Image.asset('assets/images/default.jpg', height: 100)),
              // Profile image
              const SizedBox(height: 10),
              currentUserState.isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      '${currentUserState.authEntity!.firstName} ${currentUserState.authEntity!.lastName}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
              const SizedBox(height: 20),
              ProfileMenuItem(
                  icon: Icons.brightness_6, text: 'Select Mode', onTap: () {}),
              ProfileMenuItem(
                  icon: Icons.info, text: 'Account Information', onTap: () {}),
              ProfileMenuItem(icon: Icons.lock, text: 'Password', onTap: () {}),
              ProfileMenuItem(
                  icon: Icons.favorite, text: 'Favorite', onTap: () {}),
              ProfileMenuItem(
                  icon: Icons.settings, text: 'Settings', onTap: () {}),
              ProfileMenuItem(
                  icon: Icons.fingerprint,
                  text: 'Enable Fingerprint',
                  onTap: () {
                    ref
                        .read(currentUserViewModelProvider.notifier)
                        .enableFingerprint();
                  }),

              const Divider(),
              ProfileMenuItem(
                  icon: Icons.delete,
                  text: 'Delete Account',
                  onTap: () {},
                  textColor: Colors.red),
              ProfileMenuItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  onTap: () {},
                  textColor: Colors.red),
            ],
          ),
        ),
      ),
    );
  }
}
