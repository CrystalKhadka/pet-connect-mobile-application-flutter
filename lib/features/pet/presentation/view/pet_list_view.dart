import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/presentation/widgets/my_card.dart';
import '../viewmodel/pet_view_model.dart';

class PetListView extends ConsumerStatefulWidget {
  const PetListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PetListViewState();
}

class _PetListViewState extends ConsumerState<PetListView> {
  late TextEditingController _searchController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final petState = ref.watch(petViewModelProvider);
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.extentAfter == 0) {
            if (petState.hasReachedMax) {
              return false;
            }
            ref.read(petViewModelProvider.notifier).fetchPets();
          }
        }
        return true;
      },
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Adopt Pet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      ref.read(petViewModelProvider.notifier).resetState();
                    },
                    child: const Icon(Icons.refresh),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
                controller: _searchController,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.6, // Adjust aspect ratio as needed
                  ),
                  itemCount: petState.pets.length,
                  itemBuilder: (context, index) {
                    final pet = petState.pets[index];

                    return MyCard(petEntity: pet);
                  },
                ),
              ),
              if (petState.isLoading)
                const CircularProgressIndicator()
              else if (petState.hasReachedMax)
                const Text('No more data')
              else ...{
                const SizedBox(
                  height: 10,
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
