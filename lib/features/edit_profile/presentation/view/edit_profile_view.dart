import 'dart:io';

import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/edit_profile/presentation/state/edit_profile_state.dart';
import 'package:final_assignment/features/edit_profile/presentation/viewmodel/edit_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../app/constants/api_endpoints.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  ConsumerState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  bool isEditing = false;
  File? _image;
  DateTime? _selectedDate;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController birthDateController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController emailController;

  String? gender = 'male';

  _populateControllers() async {
    await ref.read(editProfileViewModelProvider.notifier).fetchCurrentUser();
    final userState = ref.read(editProfileViewModelProvider);
    if (userState.authEntity != null) {
      firstNameController.text = userState.authEntity!.firstName ?? '';
      lastNameController.text = userState.authEntity!.lastName ?? '';
      birthDateController.text = userState.authEntity!.birthDate ?? '';
      phoneController.text = userState.authEntity!.phone ?? '';
      addressController.text = userState.authEntity!.address ?? '';
      emailController.text = userState.authEntity!.email ?? '';
      gender = userState.authEntity!.gender ?? 'male';
      // setState(() {}); // Trigger a rebuild to reflect the changes
    }
  }

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    birthDateController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    emailController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _populateControllers();
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    birthDateController.dispose();
    phoneController.dispose();
    addressController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> getImage() async {
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      showMySnackBar(message: 'Permission denied');
      return;
    }
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        ref.read(editProfileViewModelProvider.notifier).uploadImage(_image!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(editProfileViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Profile' : 'User Profile'),
        actions: [
          if (!isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => setState(() => isEditing = true),
            )
        ],
      ),
      body: userState.authEntity == null
          ? const Center(child: CircularProgressIndicator())
          : _buildProfileForm(userState),
    );
  }

  Widget _buildProfileForm(EditProfileState userState) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProfileImage(userState),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildNameFields(userState),
                    _buildEmailField(userState),
                    _buildDateField(userState),
                    _buildPhoneField(userState),
                    _buildAddressField(userState),
                    _buildGenderSelection(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (isEditing) ...[
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () => setState(() => isEditing = false),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final user = AuthEntity(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: userState.authEntity!.email,
                                  password: null,
                                  phone: phoneController.text,
                                  address: addressController.text,
                                  gender: gender,
                                  birthDate: birthDateController.text,
                                  image: userState.imageName,
                                );
                                ref
                                    .read(editProfileViewModelProvider.notifier)
                                    .updateUser(user);
                                setState(() => isEditing = false);
                              }
                            },
                            child: const Text('Save Changes'),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(EditProfileState userState) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: _getProfileImage(userState),
          ),
          if (isEditing)
            Positioned(
              bottom: 0,
              right: 0,
              child: _buildEditImageButton(),
            ),
        ],
      ),
    );
  }

  ImageProvider _getProfileImage(EditProfileState userState) {
    if (_image != null) return FileImage(_image!);
    if (userState.authEntity!.image != null) {
      return NetworkImage(
          '${ApiEndpoints.userImageUrl}${userState.authEntity!.image}');
    }
    return const AssetImage('assets/images/default.jpg');
  }

  Widget _buildEditImageButton() {
    return GestureDetector(
      onTap: getImage,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.camera_alt, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildNameFields(EditProfileState userState) {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            label: 'First Name',
            controller: firstNameController,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTextField(
            label: 'Last Name',
            controller: lastNameController,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(EditProfileState userState) {
    return _buildTextField(
      label: 'Email',
      enabled: false,
      controller: emailController,
    );
  }

  Widget _buildDateField(EditProfileState userState) {
    return _buildTextField(
      label: 'Birth Date',
      controller: birthDateController,
      suffixIcon: IconButton(
        icon: const Icon(Icons.date_range),
        onPressed: isEditing ? _selectDate : null,
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        birthDateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  Widget _buildPhoneField(EditProfileState userState) {
    return _buildTextField(
      label: 'Phone',
      controller: phoneController,
    );
  }

  Widget _buildAddressField(EditProfileState userState) {
    return _buildTextField(
      label: 'Address',
      controller: addressController,
    );
  }

  Widget _buildGenderSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Gender',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            children: ['Male', 'Female'].map((String value) {
              return Expanded(
                child: RadioListTile<String>(
                  title:
                      Text(value, style: const TextStyle(color: Colors.black)),
                  value: value.toLowerCase(),
                  groupValue: gender,
                  onChanged: isEditing
                      ? (String? newValue) {
                          setState(() => gender = newValue!);
                        }
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool enabled = true,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixIcon: suffixIcon,
        ),
        enabled: enabled && isEditing,
        validator: (value) => value!.isEmpty ? 'This field is required' : null,
      ),
    );
  }
}
