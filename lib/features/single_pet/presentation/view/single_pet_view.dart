import 'package:final_assignment/features/single_pet/presentation/state/single_pet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheet/sheet.dart';

import '../../../../app/constants/api_endpoints.dart';
import '../viewmodel/single_pet_view_model.dart';

class SinglePetView extends ConsumerStatefulWidget {
  const SinglePetView({
    super.key,
    required this.id,
  });

  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SinglePetViewState();
}

class _SinglePetViewState extends ConsumerState<SinglePetView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(singlePetViewModelProvider.notifier).init(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final petState = ref.watch(singlePetViewModelProvider);
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.network(
                '${ApiEndpoints.petImage}/${petState.petEntity?.petImage ?? ''}',
                fit: BoxFit.cover,
                height: 300,
              ),
            ),
            // Content
            Sheet(
              initialExtent: 500,
              fit: SheetFit.expand,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(petState, theme),
                      const SizedBox(height: 24),
                      _buildPetDetails(theme),
                      const SizedBox(height: 24),
                      _buildOwnerInfo(petState, theme),
                      const SizedBox(height: 24),
                      _buildDescription(petState, theme),
                    ],
                  ),
                ),
              ),
            ),
            // Back button
            Positioned(
              top: 16,
              left: 16,
              child: _buildBackButton(theme),
            ),
            // Favorite button
            Positioned(
              top: 16,
              right: 16,
              child: _buildFavoriteButton(petState, theme),
            ),
            if (petState.isLoading)
              Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                ),
              ),
          ],
        ),
        floatingActionButton: _buildAdoptButton(theme),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _buildHeader(SinglePetState petState, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                petState.petEntity?.petName ?? '',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on,
                      color: theme.colorScheme.secondary, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Kalanki (2.5 km away)',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          'Rs. 5000',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPetDetails(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDetailCard('Male', 'Sex', theme),
        _buildDetailCard('Black', 'Color', theme),
        _buildDetailCard('Bengal cat', 'Breed', theme),
        _buildDetailCard('2kg', 'Weight', theme),
      ],
    );
  }

  Widget _buildDetailCard(String title, String subtitle, ThemeData theme) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerInfo(SinglePetState petState, ThemeData theme) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/default.jpg'),
          radius: 25,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Owner',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
              Text(
                '${petState.petEntity?.createdBy?.firstName ?? ''} ${petState.petEntity?.createdBy?.lastName ?? ''}',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            ref.read(singlePetViewModelProvider.notifier).openChatView();
          },
          icon: Icon(Icons.chat_bubble),
          label: Text('Chat'),
          style: ElevatedButton.styleFrom(
            foregroundColor: theme.colorScheme.onPrimary,
            backgroundColor: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(SinglePetState petState, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          petState.petEntity?.petDescription ?? '',
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildBackButton(ThemeData theme) {
    return CircleAvatar(
      backgroundColor: theme.colorScheme.surface.withOpacity(0.7),
      child: IconButton(
        icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
        onPressed: () {
          ref.read(singlePetViewModelProvider.notifier).pop();
        },
      ),
    );
  }

  Widget _buildFavoriteButton(SinglePetState petState, ThemeData theme) {
    return CircleAvatar(
      backgroundColor: theme.colorScheme.surface.withOpacity(0.7),
      child: IconButton(
        icon: Icon(
          petState.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: petState.isFavorite
              ? theme.colorScheme.error
              : theme.colorScheme.onSurface,
        ),
        onPressed: () {
          ref
              .read(singlePetViewModelProvider.notifier)
              .toggleFavorite(petState.petEntity?.id ?? '');
        },
      ),
    );
  }

  Widget _buildAdoptButton(ThemeData theme) {
    return ElevatedButton(
      onPressed: () {
        ref.read(singlePetViewModelProvider.notifier).openAdoptionForm();
      },
      child: Text('Adopt Me'),
      style: ElevatedButton.styleFrom(
        foregroundColor: theme.colorScheme.onPrimary,
        backgroundColor: theme.colorScheme.primary,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
