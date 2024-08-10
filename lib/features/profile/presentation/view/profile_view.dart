import 'package:final_assignment/core/common/provider/dark_theme_provider.dart';
import 'package:final_assignment/core/common/widgets/my_awesome_yes_no_dialog.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:final_assignment/features/profile/presentation/viewmodel/current_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/constants/api_endpoints.dart';
import '../widgets/profile_menu_item.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => ref.read(currentUserViewModelProvider.notifier).initialize());
  }

  @override
  Widget build(BuildContext context) {
    final currentUserState = ref.watch(currentUserViewModelProvider);
    return SizedBox.expand(
      child: currentUserState.authEntity != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  await ref
                      .read(currentUserViewModelProvider.notifier)
                      .initialize();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: currentUserState.authEntity != null
                            ? Image.network(
                                '${ApiEndpoints.userImageUrl}${currentUserState.authEntity?.image ?? 'default.jpg'}',
                                height: 100)
                            : Image.asset(
                                'assets/images/default.jpg',
                                height: 100,
                              ),
                      ),
                      // Profile image
                      const SizedBox(height: 10),
                      currentUserState.isLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              '${currentUserState.authEntity?.firstName} ${currentUserState.authEntity?.lastName}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                      const SizedBox(height: 20),
                      ProfileMenuItem(
                        icon: Icons.brightness_6,
                        text: 'Select Mode',
                        onTap: () async {
                          final result = await myAwesomeYesNoDialog(
                            title: 'Are you sure?',
                            context: 'Do you want'
                                ' to change your theme?',
                          );
                          if (result) {
                            ref.read(darkThemeProvider.notifier).toggleTheme();
                          }
                        },
                      ),
                      ProfileMenuItem(
                          icon: Icons.info,
                          text: 'Account Information',
                          onTap: () {
                            ref
                                .read(currentUserViewModelProvider.notifier)
                                .openEditProfile();
                          }),
                      ProfileMenuItem(
                          icon: Icons.lock, text: 'Password', onTap: () {}),
                      ProfileMenuItem(
                          icon: Icons.favorite,
                          text: 'Favorite',
                          onTap: () {
                            ref
                                .read(currentUserViewModelProvider.notifier)
                                .openFavoriteView();
                          }),
                      ProfileMenuItem(
                          icon: Icons.pets,
                          text: 'My pets',
                          onTap: () {
                            ref
                                .read(currentUserViewModelProvider.notifier)
                                .openMyPetsView();
                          }),
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
                          onTap: () {
                            ref.read(homeViewModelProvider.notifier).logout();
                          },
                          textColor: Colors.red),
                    ],
                  ),
                ),
              ),
            )
          : const CircularProgressIndicator(),
    );
  }
}
