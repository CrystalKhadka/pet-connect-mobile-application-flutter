import 'package:final_assignment/core/common/provider/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/constants/api_endpoints.dart';
import '../../../../core/common/widgets/my_awesome_yes_no_options.dart';
import '../../../home/presentation/viewmodel/home_view_model.dart';
import '../state/current_user_state.dart';
import '../viewmodel/current_user_view_model.dart';
// Import other necessary files

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(currentUserViewModelProvider.notifier).initialize());
  }

  void openChangePasswordDialog() {
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    // Open a dialog to change password
    showDialog(
      context: context,
      builder: (context) => Consumer(
        builder: (context, ref, child) {
          return AlertDialog(
            title: const Text('Change Password'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: oldPasswordController,
                    decoration:
                        const InputDecoration(labelText: 'Old Password'),
                  ),
                  TextFormField(
                    controller: newPasswordController,
                    decoration:
                        const InputDecoration(labelText: 'New Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: confirmPasswordController,
                    decoration:
                        const InputDecoration(labelText: 'Confirm Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value != newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  ref
                      .read(currentUserViewModelProvider.notifier)
                      .changePassword(
                        oldPasswordController.text,
                        newPasswordController.text,
                      );
                  Navigator.pop(context);
                },
                child: const Text('Change'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUserState = ref.watch(currentUserViewModelProvider);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: currentUserState.authEntity != null
          ? RefreshIndicator(
              onRefresh: () async {
                await ref
                    .read(currentUserViewModelProvider.notifier)
                    .initialize();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.05,
                    vertical: screenSize.height * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenSize.height * 0.05),
                      _buildProfileImage(currentUserState),
                      SizedBox(height: screenSize.height * 0.02),
                      _buildUserName(currentUserState),
                      SizedBox(height: screenSize.height * 0.04),
                      _buildMenuItems(context),
                    ],
                  ),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildProfileImage(CurrentUserState currentUserState) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).primaryColor, width: 3),
      ),
      child: ClipOval(
        child: currentUserState.authEntity?.image != null
            ? Image.network(
                '${ApiEndpoints.userImageUrl}${currentUserState.authEntity?.image}',
                fit: BoxFit.cover,
              )
            : Image.asset(
                'assets/images/default.jpg',
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget _buildUserName(CurrentUserState currentUserState) {
    return currentUserState.isLoading
        ? const CircularProgressIndicator()
        : Text(
            '${currentUserState.authEntity?.firstName} ${currentUserState.authEntity?.lastName}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            _buildMenuItem(
              icon: Icons.brightness_6,
              text: 'Select Mode',
              onTap: () async {
                //   get a dropdown for auto, light, dark
                final theme = await myAwesomeYesNoOptions(
                  title: 'Select Mode',
                  options: ['Auto', 'Light', 'Dark'],
                );
                print(theme);
                if (theme.isNotEmpty) {
                  ref
                      .read(themeViewModelProvider.notifier)
                      .toggleTheme(theme.toLowerCase());
                }
              },
            ),
            _buildMenuItem(
              icon: Icons.info,
              text: 'Account Information',
              onTap: () => ref
                  .read(currentUserViewModelProvider.notifier)
                  .openEditProfile(),
            ),
            _buildMenuItem(
              icon: Icons.lock,
              text: 'Password',
              onTap: openChangePasswordDialog,
            ),
            _buildMenuItem(
              icon: Icons.favorite,
              text: 'Favorite',
              onTap: () => ref
                  .read(currentUserViewModelProvider.notifier)
                  .openFavoriteView(),
            ),
            _buildMenuItem(
              icon: Icons.pets,
              text: 'My pets',
              onTap: () => ref
                  .read(currentUserViewModelProvider.notifier)
                  .openMyPetsView(),
            ),
            _buildMenuItem(
              icon: Icons.fingerprint,
              text: 'Enable Fingerprint',
              onTap: () => ref
                  .read(currentUserViewModelProvider.notifier)
                  .enableFingerprint(),
            ),
            const Divider(),
            _buildMenuItem(
              icon: Icons.delete,
              text: 'Delete Account',
              onTap: () {},
              textColor: Colors.red,
            ),
            _buildMenuItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () => ref.read(homeViewModelProvider.notifier).logout(),
              textColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        text,
        style: TextStyle(
          color: textColor,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
