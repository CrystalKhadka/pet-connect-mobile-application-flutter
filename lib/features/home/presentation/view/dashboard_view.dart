import 'package:final_assignment/features/home/presentation/view/bottom_screen/chat_view.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_screen/home_view.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_screen/pet_list_view.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_screen/settings_view.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  int currentIndex = 0;
  final List<Widget> _children = [
    const HomeView(),
    const PetListView(),
    const ChatView(),
    const SettingsView(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text('Pet Connect'),
              const Spacer(),
              IconButton(
                // Total notifications 2
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person),
              ),
              IconButton(
                onPressed: () {
                  // Logout
                  ref.read(homeViewModelProvider.notifier).openLoginView();
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
        ),
        body: _children[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pets),
              label: 'Pet List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
