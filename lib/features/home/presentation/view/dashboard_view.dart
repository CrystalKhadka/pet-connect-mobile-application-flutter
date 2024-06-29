import 'package:final_assignment/features/home/presentation/view/bottom_screen/chat_view.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_screen/home_view.dart';
import 'package:final_assignment/features/pet/presentation/view/pet_list_view.dart';
import 'package:final_assignment/features/settings/presentation/view/profile_view.dart';
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
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              icon: Icon(Icons.person),
              label: 'Profile',
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
