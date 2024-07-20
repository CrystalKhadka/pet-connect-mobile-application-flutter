import 'package:final_assignment/features/adoption/domain/entity/form_entity.dart';
import 'package:final_assignment/features/adoption/presentation/viewmodel/adoption_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdoptionFormView extends ConsumerStatefulWidget {
  const AdoptionFormView(this.petId, {super.key});

  final String petId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdoptionFormViewState();
}

class _AdoptionFormViewState extends ConsumerState<AdoptionFormView> {
  late TextEditingController _fullNameController;
  late TextEditingController _ageController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _houseOrApartmentController;
  late TextEditingController _yardOrOutdoorSpaceController;
  late TextEditingController _ownedPetsController;
  late TextEditingController _adoptionReasonController;
  String gender = 'M';
  String? _houseDropDownValue;
  String? _yardDropDownValue;

  @override
  void initState() {
    _fullNameController = TextEditingController(text: 'Crystal Khadka');
    _ageController = TextEditingController(text: '12');
    _emailController = TextEditingController(text: 'khadkacrystal23gmail.com');
    _phoneController = TextEditingController(text: '9843041037');
    _houseOrApartmentController = TextEditingController(text: 'House');
    _yardOrOutdoorSpaceController = TextEditingController(text: 'Yes');
    _ownedPetsController = TextEditingController(text: 'I have some');
    _adoptionReasonController = TextEditingController(text: 'companion');

    super.initState();
    Future.microtask(
      () => {
        ref.read(adoptionViewModelProvider.notifier).setPet(widget.petId),
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adoptionState = ref.watch(adoptionViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Row(
          children: [
            SizedBox(width: 8),
            Text('Pet Connect', style: TextStyle(color: Colors.black)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.grey[600]),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(
              icon: Icons.person,
              label: 'Full Name',
              controller: _fullNameController,
            ),
            _buildTextField(
              icon: Icons.calendar_today,
              label: 'Age',
              keyboardType: TextInputType.number,
              controller: _ageController,
            ),
            _buildTextField(
              icon: Icons.email,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Male'),
                      value: 'M',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                        title: const Text('Female'),
                        value: 'F',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        }),
                  ),
                ],
              ),
            ),
            _buildTextField(
              icon: Icons.phone,
              label: 'Phone',
              keyboardType: TextInputType.phone,
              controller: _phoneController,
            ),
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: 'House', child: Text('House')),
                DropdownMenuItem(value: 'Apartment', child: Text('Apartment')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              value: _houseDropDownValue,
              onChanged: (value) {
                _houseDropDownValue = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                labelText: 'Do you live in a house or apartment?',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: 'Yes', child: Text('Yes')),
                DropdownMenuItem(value: 'No', child: Text('No')),
              ],
              value: _yardDropDownValue,
              onChanged: (value) {
                _yardDropDownValue = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                labelText: 'Do you have a yard or outdoor space?',
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label:
                  'Have you owned pets before? If yes, please describe your experience.',
              controller: _ownedPetsController,
              maxLines: 3,
            ),
            _buildTextField(
              label: 'Why do you want to adopt this particular pet?',
              controller: _adoptionReasonController,
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Text(
              'You might need to wait for some time for confirmation.',
              style: TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                FormEntity form = FormEntity(
                  fullName: _fullNameController.text,
                  email: _emailController.text,
                  phone: _phoneController.text,
                  age: double.parse(_ageController.text),
                  gender: gender,
                  houseType: _houseDropDownValue!,
                  reason: _adoptionReasonController.text,
                  yard: _yardDropDownValue!,
                  petExperience: _ownedPetsController.text,
                );

                ref.read(adoptionViewModelProvider.notifier).submitForm(form);
              },
              child: const Text('Confirm'),
            ),
            if (adoptionState.isLoading) const LinearProgressIndicator(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Pet List'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildTextField({
    IconData? icon,
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
      ),
    );
  }
}
