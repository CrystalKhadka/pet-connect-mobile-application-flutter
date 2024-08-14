import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/constants/api_endpoints.dart';
import '../../../../core/common/provider/dark_theme_provider.dart';
import '../../../../core/common/widgets/my_awesome_yes_no_dialog.dart';
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
                final result = await myAwesomeYesNoDialog(
                  title: 'Are you sure?',
                  context: 'Do you want to change your theme?',
                );
                if (result) {
                  ref.read(darkThemeProvider.notifier).toggleTheme();
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
              onTap: () {},
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
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(
        text,
        style: TextStyle(
          color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      trailing:
          Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
      onTap: onTap,
    );
  }
}
