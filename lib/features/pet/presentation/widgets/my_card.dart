import 'package:final_assignment/app/constants/api_endpoints.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key, required this.petEntity, this.onTap, this.onAdopt});

  final PetEntity petEntity;
  final VoidCallback? onTap;
  final VoidCallback? onAdopt;

  @override
  Widget build(BuildContext context) {
    bool favorite = false;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        return GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: 'pet_image_${petEntity.id}',
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16)),
                        child: Image.network(
                          '${ApiEndpoints.petImage}${petEntity.petImage}',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: isSmallScreen ? 150 : 200,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: isSmallScreen ? 150 : 200,
                            color: Colors.grey[300],
                            child: const Icon(Icons.error, color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.pets,
                                color: Colors.blue, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              petEntity.petSpecies,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: IconButton(
                            icon: Icon(
                              favorite ? Icons.favorite : Icons.favorite_border,
                              color: favorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              petEntity.petName,
                              style: Theme.of(context).textTheme.titleLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              petEntity.petBreed,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Age: ${petEntity.petAge} months',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: onAdopt,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Adopt Me'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
