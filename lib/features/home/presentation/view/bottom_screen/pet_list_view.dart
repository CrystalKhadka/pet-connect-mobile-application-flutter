import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PetListView extends ConsumerStatefulWidget {
  const PetListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PetListViewState();
}

class _PetListViewState extends ConsumerState<PetListView> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Pet List Screen',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
