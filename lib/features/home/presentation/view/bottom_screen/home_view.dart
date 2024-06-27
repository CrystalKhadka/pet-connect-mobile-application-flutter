import 'package:final_assignment/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:final_assignment/features/home/presentation/widgets/my_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late TextEditingController _searchController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final petState = ref.watch(homeViewModelProvider);
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.extentAfter == 0) {
            if (petState.hasReachedMax) {
              return false;
            }
            ref.read(homeViewModelProvider.notifier).fetchPets();
          }
        }
        return true;
      },
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
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
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.filter_alt),
                    onPressed: () {},
                  ),
                ),
                controller: _searchController,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pet Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'More Category',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Flexible(
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1,
                  ),
                  itemCount: petState.species.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Center(
                        child: Text(petState.species[index]),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
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
                  TextButton(
                    onPressed: () {
                      ref.read(homeViewModelProvider.notifier).resetState();
                    },
                    child: const Icon(Icons.refresh),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 3,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: petState.pets.length,
                  itemBuilder: (context, index) {
                    return MyCard(petEntity: petState.pets[index]);
                  },
                ),
              ),
              if (petState.isLoading) ...{
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: CircularProgressIndicator(color: Colors.red),
                )
              },
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
