import 'package:final_assignment/app/constants/api_endpoints.dart';
import 'package:final_assignment/features/single_pet/presentation/viewmodel/single_pet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheet/sheet.dart';

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
      ref.read(singlePetViewModelProvider.notifier).fetchPetById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final petState = ref.watch(singlePetViewModelProvider);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Stack(
                children: [
                  // Image
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Image.network(
                      '${ApiEndpoints.petImage}/${petState.petEntity?.petImage ?? ''}',
                      fit: BoxFit.fill,
                      height: 300,
                    ),
                  ),
                  // Back button
                  Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                      onPressed: () {
                        ref
                            .read(singlePetViewModelProvider.notifier)
                            .openPetView();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  // Favorite button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Sheet(
                  initialExtent: 500,
                  fit: SheetFit.expand,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Name: ',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              petState.petEntity?.petName ?? '',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(Icons.location_on),
                                      Text('Kalanki (2.5 km away)'),
                                    ],
                                  )
                                ],
                              ),
                              const Text('Rs. 5000')
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                width: 80,
                                height: 80,
                                child: const Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Male',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Sex',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                width: 80,
                                height: 80,
                                child: const Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Black',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Color',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                width: 80,
                                height: 80,
                                child: const Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Bengal cat',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Breed',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                width: 80,
                                height: 80,
                                child: const Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '2kg',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Weight',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Image(
                                image: AssetImage('assets/images/default.jpg'),
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                  'Owner by\n${petState.petEntity?.createdBy?.firstName ?? ''} ${petState.petEntity?.createdBy?.lastName ?? ''}'),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: const Column(
                                  children: [
                                    Icon(Icons.chat_bubble),
                                    Text('Chat'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            petState.petEntity?.petDescription ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (petState.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
              onPressed: () {
                ref
                    .read(singlePetViewModelProvider.notifier)
                    .openAdoptionForm();
              },
              child: const SizedBox(
                child: Text('Adopt Me'),
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
