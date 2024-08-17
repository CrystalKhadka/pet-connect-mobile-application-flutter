import 'package:final_assignment/features/favorite/domain/entity/favorite_entity.dart';
import 'package:final_assignment/features/favorite/presentation/viewmodel/favorite_view_model.dart';
import 'package:final_assignment/features/favorite/presentation/widgets/pet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends ConsumerState<FavoriteView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(favoriteViewModelProvider.notifier).fetchFavoritePets();
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteState = ref.watch(favoriteViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoriteState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : favoriteState.error.isNotEmpty
              ? buildErrorWidget(context, favoriteState.error)
              : favoriteState.favorites.isEmpty
                  ? buildEmptyFavorites(context)
                  : buildFavoritesList(context, favoriteState.favorites),
    );
  }

  Widget buildErrorWidget(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error,
            style: const TextStyle(fontSize: 18, color: Colors.red),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Reload favorites
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyFavorites(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.pets, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'You haven\'t added any pets to your favorites yet.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start exploring and heart the pets you love!',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navigate to pet list
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Explore Pets'),
          ),
        ],
      ),
    );
  }

  Widget buildFavoritesList(
      BuildContext context, List<FavoriteEntity> favorites) {
    final pets = favorites.map((favorite) => favorite.pet).toList();
    return AnimationLimiter(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1.1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: pets.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 375),
            columnCount: 2,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: PetCard(
                  pet: pets[index],
                  favorite: () {
                    ref
                        .read(favoriteViewModelProvider.notifier)
                        .toggleFavorite(pets[index].id ?? '');
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
