import 'package:final_assignment/features/pet/presentation/widgets/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/pet_view_model.dart';
import '../widgets/my_card.dart';

class PetListView extends ConsumerStatefulWidget {
  const PetListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PetListViewState();
}

class _PetListViewState extends ConsumerState<PetListView> {
  late TextEditingController _searchController;
  final ScrollController _scrollController = ScrollController();
  String? _selectedSpecies;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isTabletDevice = DeviceInfo.isTabletDevice();
    final petState = ref.watch(petViewModelProvider);

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.extentAfter == 0) {
            ref.read(petViewModelProvider.notifier).fetchPets(petState.limit);
          }
        }
        return true;
      },
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RefreshIndicator(
            onRefresh: () {
              return ref.read(petViewModelProvider.notifier).resetState();
            },
            child: Column(
              children: [
                const SizedBox(height: 20),
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
                    TextButton(
                      onPressed: () {
                        showFilterDialog(context, petState.species);
                      },
                      child: const Icon(Icons.filter_alt),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isTabletDevice ? 3 : 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: isTabletDevice ? 1.5 : 0.6,
                    ),
                    itemCount: petState.pets.length,
                    itemBuilder: (context, index) {
                      final pet = petState.pets[index];
                      if (_selectedSpecies == null ||
                          pet.petSpecies == _selectedSpecies) {
                        return GestureDetector(
                          child: MyCard(petEntity: pet),
                          onDoubleTap: () {
                            ref
                                .read(petViewModelProvider.notifier)
                                .openSinglePetView();
                          },
                        );
                      }
                      return Container(); // Empty container if pet does not match the selected species
                    },
                  ),
                ),
                if (petState.isLoading)
                  const CircularProgressIndicator()
                else ...{
                  const SizedBox(height: 10),
                }
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showFilterDialog(BuildContext context, List<String> species) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter by Species'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: species.map((species) {
              return ListTile(
                title: Text(species),
                onTap: () {
                  setState(() {
                    _selectedSpecies = species;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
