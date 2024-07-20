import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/pet_view_model.dart';
import '../widgets/device_info.dart';
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
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTabletDevice = DeviceInfo.isTabletDevice();
    final petState = ref.watch(petViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adopt a Pet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(petViewModelProvider.notifier).resetState(),
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => showFilterDialog(context, petState.species),
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              _scrollController.position.extentAfter == 0) {
            ref.read(petViewModelProvider.notifier).fetchPets(petState.limit);
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: () => ref.read(petViewModelProvider.notifier).resetState(),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverToBoxAdapter(
                  child: SearchBar(
                    controller: _searchController,
                    onSearch: (value) {
                      // Implement search functionality
                    },
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: isTabletDevice ? 2.5 : 1.2,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final pet = petState.pets[index];
                      if (_selectedSpecies == null ||
                          pet.petSpecies == _selectedSpecies) {
                        return GestureDetector(
                          child: MyCard(
                              petEntity: pet,
                              onTap: () {},
                              onAdopt: () {
                                ref
                                    .read(petViewModelProvider.notifier)
                                    .openAdoptionForm(pet.id!);
                              }),
                          onDoubleTap: () => ref
                              .read(petViewModelProvider.notifier)
                              .openSinglePetView(pet.id!),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    childCount: petState.pets.length,
                  ),
                ),
              ),
              if (petState.isLoading)
                const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
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
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  title: const Text('All Species'),
                  onTap: () {
                    setState(() => _selectedSpecies = null);
                    Navigator.of(context).pop();
                  },
                ),
                ...species.map((species) => ListTile(
                      title: Text(species),
                      onTap: () {
                        setState(() => _selectedSpecies = species);
                        Navigator.of(context).pop();
                      },
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const SearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search pets...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      onSubmitted: onSearch,
    );
  }
}
