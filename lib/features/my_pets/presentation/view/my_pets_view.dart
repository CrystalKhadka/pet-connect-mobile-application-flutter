import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPetsView extends ConsumerStatefulWidget {
  const MyPetsView({super.key});

  @override
  ConsumerState createState() => _MyPetsViewState();
}

class _MyPetsViewState extends ConsumerState<MyPetsView> {
  final List<Map<String, dynamic>> dummyAdoptedPets = [
    {
      "form": {
        "fname": "Crystal",
        "lname": "Khadka",
        "email": "khadkacrystal23@gmail.com",
        "age": 20,
        "phone": "9843041037",
        "gender": "m",
        "houseType": "House",
        "reason": "t",
        "yard": "Yard",
        "petExperience": "t"
      },
      "_id": "66acb814e1bd8681ba868479",
      "formSender": {
        "_id": "66acadd120f67086c37a6d44",
        "firstName": "Crystal",
        "lastName": "Khadka",
        "email": "khadkacrystal23@gmail.com",
      },
      "formReceiver": {
        "_id": "66aa3efa108a429505bdf791",
        "firstName": "Crystal",
        "lastName": "Khadka",
        "email": "khadkacrystal@gmail.com",
      },
      "pet": {
        "_id": "66aa3fd0108a429505bdf7a4",
        "petName": "Goldy",
        "petSpecies": "dog",
        "petBreed": "golden retriever",
        "petAge": 4,
        "petWeight": 6,
        "petColor": "gold",
        "petDescription": "This is Goldy",
        "petImage": "https://example.com/pet-image.jpg",
        "petStatus": "pending",
      },
      "status": "pending",
      "createdAt": "2024-08-02T10:29:12.310Z",
    },
    // Add more dummy pet entries here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Adopted Pets'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: dummyAdoptedPets.isEmpty
            ? Center(
                child: Text(
                  'You haven\'t adopted any pets yet.',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: dummyAdoptedPets.length,
                itemBuilder: (context, index) {
                  return MyPetCard(singleAdoption: dummyAdoptedPets[index]);
                },
              ),
      ),
    );
  }
}

class MyPetCard extends StatelessWidget {
  final Map<String, dynamic> singleAdoption;

  const MyPetCard({Key? key, required this.singleAdoption}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
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
                  singleAdoption['pet']['petImage'],
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 250,
                      color: Colors.grey[300],
                      child:
                          Icon(Icons.pets, size: 50, color: Colors.grey[500]),
                    );
                  },
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: singleAdoption['status'] == 'approved'
                        ? Colors.green
                        : singleAdoption['status'] == 'pending'
                            ? Colors.yellow
                            : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    singleAdoption['status'].toString().capitalize(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  singleAdoption['pet']['petName'],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Species: ${singleAdoption['pet']['petSpecies']}',
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  'Age: ${singleAdoption['pet']['petAge']} months',
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  'Breed: ${singleAdoption['pet']['petBreed']}',
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  'Color: ${singleAdoption['pet']['petColor']}',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Navigate to pet details
                        print(
                            'View details for ${singleAdoption['pet']['petName']}');
                      },
                      child: const Text('View Details'),
                    ),
                    ElevatedButton(
                      onPressed: singleAdoption['status'] == 'pending'
                          ? null
                          : () {
                              // Navigate to donation page
                              print(
                                  'Donate for ${singleAdoption['pet']['petName']}');
                            },
                      child: const Text('Donate'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
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
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
