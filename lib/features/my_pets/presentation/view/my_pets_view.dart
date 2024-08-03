import 'package:final_assignment/app/constants/api_endpoints.dart';
import 'package:final_assignment/features/adoption/domain/entity/adoption_entity.dart';
import 'package:final_assignment/features/adoption/domain/entity/form_entity.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/my_pets/presentation/viewmodel/my_pets_view_model.dart';
import 'package:final_assignment/features/pet/domain/entity/pet_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPetsView extends ConsumerStatefulWidget {
  const MyPetsView({super.key});

  @override
  ConsumerState createState() => _MyPetsViewState();
}

class _MyPetsViewState extends ConsumerState<MyPetsView> {
  final List<AdoptionEntity> dummyAdoptedPets = [
    AdoptionEntity(
      id: '1',
      pet: const PetEntity(
        id: '1',
        petName: 'Bella',
        petSpecies: 'Dog',
        petAge: 3,
        petBreed: 'Golden Retriever',
        petColor: 'Golden',
        petImage: 'https://images.unsplash.com/photo-1560807707-8cc777a4d1f2',
        petWeight: 3,
        petDescription:
            'Bella is a very friendly dog. She loves to play with kids and other pets. She is very active and loves to go for a walk.',
        petStatus: 'available',
        createdAt: '2022-01-01',
        createdBy: AuthEntity(
          firstName: 'John',
          lastName: 'Doe',
          email: 'j@gmail.com',
          password: '1234567890',
          phone: '1234567890',
          address: 'KTM',
          gender: 'Male',
          birthDate: '2022-01-01',
          image: 'https://images.unsplash.com/photo-1560807707-8cc777a4d1f2',
        ),
      ),
      formReceiver: const AuthEntity(
        firstName: 'John',
        lastName: 'Doe',
        email: 'j@gmail.com',
        password: '1234567890',
        phone: '1234567890',
        address: 'KTM',
        gender: 'Male',
        birthDate: '2022-01-01',
        image: 'https://images.unsplash.com/photo-1560807707-8cc777a4d1f2',
      ),
      formSender: const AuthEntity(
        firstName: 'Crystal',
        lastName: 'Doe',
        email: 'c@gmail.com',
        password: '1234567890',
        phone: '1234567890',
        address: 'KTM',
        gender: 'Male',
        birthDate: '2022-01-01',
        image: 'https://images.unsplash.com/photo-1560807707-8cc777a4d1f2',
      ),
      form: const FormEntity(
        fullName: 'fullName',
        email: 'email',
        phone: 'phone',
        age: 11,
        gender: 'm',
        houseType: 'houseType',
        reason: 'reason',
        yard: 'yard',
        petExperience: 'petExperience',
      ),
      status: 'approved',
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myPetsViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Adopted Pets'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(myPetsViewModelProvider.notifier).getMyPets();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: state.error != null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 80, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      state.error.toString(),
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ],
                ),
              )
            : state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.adoptions.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.pets, size: 80, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              'You haven\'t adopted any pets yet.',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: state.adoptions.length,
                        itemBuilder: (context, index) {
                          final singleAdoption = state.adoptions[index];
                          return MyPetCard(
                              singleAdoption: singleAdoption,
                              viewPressed: () {
                                ref
                                    .read(myPetsViewModelProvider.notifier)
                                    .openSinglePetView(
                                        singleAdoption.pet?.id ?? '');
                              });
                        },
                      ),
      ),
    );
  }
}

class MyPetCard extends StatelessWidget {
  final AdoptionEntity singleAdoption;
  final VoidCallback viewPressed;

  const MyPetCard(
      {super.key, required this.singleAdoption, required this.viewPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  '${ApiEndpoints.petImage}${singleAdoption.pet?.petImage}',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[300],
                      child:
                          Icon(Icons.pets, size: 80, color: Colors.grey[500]),
                    );
                  },
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(singleAdoption.status ?? ''),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    singleAdoption.status.toString().capitalize(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  singleAdoption.pet?.petName ?? '',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.pets, '${singleAdoption.pet?.petSpecies}'),
                _buildInfoRow(
                    Icons.cake, '${singleAdoption.pet?.petAge} months'),
                _buildInfoRow(
                    Icons.color_lens, '${singleAdoption.pet?.petBreed}'),
                _buildInfoRow(Icons.palette, '${singleAdoption.pet?.petColor}'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      onPressed: viewPressed,
                      icon: const Icon(Icons.info_outline),
                      label: const Text('View Details'),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: singleAdoption.status == 'pending'
                          ? null
                          : () {
                              print(
                                  'Donate for ${singleAdoption.pet?.petName}');
                            },
                      icon: const Icon(Icons.favorite),
                      label: const Text('Donate'),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(130, 60),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
