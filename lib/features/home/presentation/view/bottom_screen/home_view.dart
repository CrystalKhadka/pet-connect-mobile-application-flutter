import 'package:badges/badges.dart' as badge;
import 'package:final_assignment/core/common/widgets/my_snackbar.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app/constants/api_endpoints.dart';
import '../../../../../app/constants/theme_constant.dart';
import '../../../../../core/common/provider/internet_connectivity.dart';
import '../../state/home_state.dart';
import '../../viewmodel/home_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late TextEditingController _searchController;
  final ScrollController _scrollController = ScrollController();

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
    final homeState = ref.watch(homeViewModelProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final connection = ref.watch(connectivityStatusProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text('Pet Connect', style: theme.textTheme.titleLarge),
        actions: [
          badge.Badge(
            position: badge.BadgePosition.topEnd(top: 5, end: 5),
            badgeContent: Text(
              homeState.notificationCount.toString(),
              style:
                  TextStyle(color: theme.colorScheme.onPrimary, fontSize: 12),
            ),
            child: IconButton(
              icon: Icon(Icons.notifications_outlined,
                  color: theme.iconTheme.color),
              onPressed: () {},
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person_outline, color: theme.iconTheme.color),
          ),
          IconButton(
            onPressed: () {
              ref.read(homeViewModelProvider.notifier).logout();
            },
            icon: Icon(Icons.logout, color: theme.iconTheme.color),
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              _scrollController.position.extentAfter == 0) {
            if (connection == ConnectivityStatus.isConnected) {
              ref.read(homeViewModelProvider.notifier).fetchPets();
            } else {
              showMySnackBar(message: "No connection", color: Colors.red);
            }
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: () async {
            if (connection == ConnectivityStatus.isConnected) {
              ref.read(homeViewModelProvider.notifier).resetState();
            } else {
              showMySnackBar(message: "No connection", color: Colors.red);
            }
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(ThemeConstant.mediumSpacing),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildSearchBar(theme),
                    const SizedBox(height: ThemeConstant.largeSpacing),
                    _buildPetCategories(homeState, theme),
                    const SizedBox(height: ThemeConstant.largeSpacing),
                    _buildAdoptPetHeader(theme),
                  ]),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                    horizontal: ThemeConstant.mediumSpacing),
                sliver: _buildAdoptPetGrid(homeState, theme),
              ),
              if (homeState.isLoading)
                const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(ThemeConstant.mediumSpacing),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(ThemeConstant.mediumBorderRadius),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Search for pets',
          hintStyle:
              theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          suffixIcon: Icon(Icons.search, color: theme.iconTheme.color),
          prefixIcon: Icon(Icons.filter_alt, color: theme.iconTheme.color),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        controller: _searchController,
      ),
    );
  }

  Widget _buildPetCategories(HomeState homeState, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pet Categories',
              style: theme.textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: ThemeConstant.smallSpacing),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeState.species.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.only(right: ThemeConstant.smallSpacing),
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                            ThemeConstant.mediumBorderRadius),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.pets,
                          size: 30,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: ThemeConstant.smallSpacing),
                    Text(
                      homeState.species[index],
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAdoptPetHeader(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Adopt a Pet',
          style: theme.textTheme.titleLarge,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'See All',
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildAdoptPetGrid(HomeState homeState, ThemeData theme) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: ThemeConstant.mediumSpacing,
        crossAxisSpacing: ThemeConstant.mediumSpacing,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return MyCard(petEntity: homeState.pets[index]);
        },
        childCount: homeState.pets.length,
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({Key? key, required this.petEntity}) : super(key: key);

  final PetEntity petEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: ThemeConstant.lowElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ThemeConstant.mediumBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(ThemeConstant.mediumBorderRadius)),
              child: Image.network(
                '${ApiEndpoints.petImage}${petEntity.petImage}',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(ThemeConstant.smallSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    petEntity.petName,
                    style: theme.textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    petEntity.petBreed,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Age: ${petEntity.petAge} months',
                    style: theme.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
