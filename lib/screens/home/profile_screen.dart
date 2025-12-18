import 'dart:io';
import 'package:flutter/material.dart';
import 'package:grabby_app/core/constant/app_colors.dart';
import 'package:grabby_app/core/constant/app_routes.dart';
import 'package:grabby_app/models/user_profile_model.dart';
import 'package:grabby_app/services/auth_service.dart';
import 'package:grabby_app/services/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:grabby_app/widgets/custom_text_field_login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _bioController;
  bool _isEditing = false;
  bool _isSaving = false;
  bool _initialized = false;

  void _initControllers(UserProfileModel user) {
    _nameController = TextEditingController(text: user.name);
    _phoneController = TextEditingController(text: user.phoneNumber ?? '');
    _addressController = TextEditingController(text: user.address ?? '');
    _bioController = TextEditingController(text: user.bio ?? '');
    _initialized = true;
  }

  @override
  void dispose() {
    if (_initialized) {
      _nameController.dispose();
      _phoneController.dispose();
      _addressController.dispose();
      _bioController.dispose();
    }
    super.dispose();
  }

  Future<void> _save(UserService userService) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isSaving = true;
    });

    final data = {
      'name': _nameController.text.trim(),
      'phoneNumber': _phoneController.text.trim(),
      'address': _addressController.text.trim(),
      'bio': _bioController.text.trim(),
    };

    final success = await userService.updateUserProfile(data);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      setState(() {
        _isEditing = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(userService.errorMessage ?? 'Failed to save'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    if (mounted) {
      setState(() {
        _isSaving = false;
      });
    }
  }

  void _cancel(UserService userService) {
    final user = userService.userProfile!;
    _nameController.text = user.name;
    _phoneController.text = user.phoneNumber ?? '';
    _addressController.text = user.address ?? '';
    _bioController.text = user.bio ?? '';
    setState(() {
      _isEditing = false;
    });
  }

  Future<void> _pickImage(
    BuildContext context,
    String uid,
    UserService userService,
  ) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final imageUrl = await userService.uploadProfilePicture(uid, imageFile);
      if (imageUrl != null) {
        await userService.updateUserProfile({'profilePictureUrl': imageUrl});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Builder(
            builder: (ctx) {
              final userService = ctx.watch<UserService>();
              if (userService.userProfile == null)
                return const SizedBox.shrink();
              return _isEditing
                  ? Row(
                      children: [
                        TextButton(
                          onPressed: _isSaving
                              ? null
                              : () => _cancel(userService),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: _isSaving
                              ? null
                              : () => _save(userService),
                          child: _isSaving
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Save'),
                        ),
                      ],
                    )
                  : IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () {
                        setState(() {
                          _isEditing = true;
                        });
                      },
                    );
            },
          ),
        ],
      ),
      body: Consumer2<AuthService, UserService>(
        builder: (context, authService, userService, child) {
          if (userService.isLoading && userService.userProfile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (authService.currentUser == null ||
              userService.userProfile == null) {
            return _buildLoggedOutView(context);
          }

          final user = userService.userProfile!;

          if (!_initialized) {
            _initControllers(user);
          }

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: user.profilePictureUrl != null
                            ? NetworkImage(user.profilePictureUrl!)
                            : null,
                        child: user.profilePictureUrl == null
                            ? Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.grey.shade600,
                              )
                            : null,
                      ),
                      if (userService.isLoading)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () =>
                              _pickImage(context, user.uid, userService),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.softblue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _isEditing
                      ? TextFormField(
                          controller: _nameController,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        )
                      : Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Contact',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _isEditing
                            ? CustomTextField(
                                controller: _phoneController,
                                hintText: 'Phone Number',
                                keyboardType: TextInputType.phone,
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty)
                                    return 'Please enter phone number';
                                  if (v.trim().length < 7)
                                    return 'Please enter a valid phone number';
                                  return null;
                                },
                              )
                            : ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(
                                  Icons.phone_outlined,
                                  color: AppColors.softblue,
                                ),
                                title: const Text(
                                  'Phone Number',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(user.phoneNumber ?? 'Not set'),
                              ),
                        const SizedBox(height: 16),
                        const Text(
                          'Address',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _isEditing
                            ? CustomTextField(
                                controller: _addressController,
                                hintText: 'Address',
                                keyboardType: TextInputType.streetAddress,
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty)
                                    return 'Please enter address';
                                  return null;
                                },
                              )
                            : ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.softblue,
                                ),
                                title: const Text(
                                  'Address',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(user.address ?? 'Not set'),
                              ),
                        const SizedBox(height: 16),
                        const Text(
                          'Bio',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _isEditing
                            ? CustomTextField(
                                controller: _bioController,
                                hintText: 'Short bio',
                                keyboardType: TextInputType.text,
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty)
                                    return 'Please enter bio';
                                  return null;
                                },
                              )
                            : ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(
                                  Icons.info_outline,
                                  color: AppColors.softblue,
                                ),
                                title: const Text(
                                  'Bio',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(user.bio ?? 'Not set'),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_isEditing) {
                      await _save(userService);
                    } else {
                      setState(() => _isEditing = true);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.softblue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _isEditing
                        ? (_isSaving ? 'Saving...' : 'Save Changes')
                        : 'Edit Profile',
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () async {
                  await authService.signOut();
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.login,
                      (route) => false,
                    );
                  }
                },
                icon: const Icon(Icons.logout),
                label: const Text('Sign Out'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.red.withOpacity(0.1),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoggedOutView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('You are not logged in.'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false),
            child: const Text('Go to Login'),
          ),
        ],
      ),
    );
  }
}
