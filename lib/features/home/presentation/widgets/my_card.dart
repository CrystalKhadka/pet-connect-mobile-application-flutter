import 'package:final_assignment/app/constants/api_endpoints.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key, required this.petEntity});

  final PetEntity petEntity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  '${ApiEndpoints.petImage}${petEntity.petImage}',
                  fit: BoxFit.cover,
                  height: 150,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  petEntity.petName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  petEntity.petDescription,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  petEntity.petAge.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
