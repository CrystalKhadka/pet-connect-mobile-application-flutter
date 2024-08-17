import 'package:final_assignment/core/common/provider/theme_view_model.dart';
import 'package:final_assignment/features/all_chat/presentation/viewmodel/all_chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllChatView extends ConsumerWidget {
  const AllChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(allChatViewModelProvider);
    final themeState = ref.watch(themeViewModelProvider);

    return Container(
      decoration: BoxDecoration(
        color: themeState.isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Users',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: themeState.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          if (state.isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Expanded(
              child: ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(
                      '${user.firstName} ${user.lastName} (${user.email})',
                      style: TextStyle(
                        color:
                            themeState.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    onTap: () {
                      ref
                          .read(allChatViewModelProvider.notifier)
                          .openChatView(user.id ?? "");
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
