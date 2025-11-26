import 'dart:io';
import 'package:flutter/material.dart';
import 'package:grabby_app/core/constant/app_colors.dart';
import 'package:grabby_app/core/constant/app_routes.dart';
import 'package:grabby_app/models/user_profile_model.dart';
import 'package:grabby_app/services/auth_service.dart';
import 'package:grabby_app/services/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.white,
        elevation: 1,
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

          final userProfile = userService.userProfile!;

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildProfileHeader(context, userProfile, userService),
              const SizedBox(height: 24),
              _buildProfileInfoCard(context, userProfile, userService),
              const SizedBox(height: 24),
              _buildSignOutButton(context, authService),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    UserProfileModel user,
    UserService userService,
  ) {
    return Column(
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
                  ? Icon(Icons.person, size: 60, color: Colors.grey.shade600)
                  : null,
            ),
            // Loading indicator overlay
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
                onTap: () => _pickImage(context, user.uid, userService),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.softblue,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          user.name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildProfileInfoCard(
    BuildContext context,
    UserProfileModel user,
    UserService userService,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          _buildInfoTile(
            context: context,
            icon: Icons.person_outline,
            title: 'Name',
            value: user.name,
            onEdit: () =>
                _showEditDialog(context, 'Update Name', user.name, (newName) {
                  userService.updateUserProfile({'name': newName});
                }),
          ),
          _buildInfoTile(
            context: context,
            icon: Icons.phone_outlined,
            title: 'Phone Number',
            value: user.phoneNumber ?? 'Not set',
            onEdit: () => _showEditDialog(
              context,
              'Update Phone Number',
              user.phoneNumber ?? '',
              (newPhone) {
                userService.updateUserProfile({'phoneNumber': newPhone});
              },
            ),
          ),
          _buildInfoTile(
            context: context,
            icon: Icons.email_outlined,
            title: 'Email',
            value: user.email,
          ), // Email is not editable
        ],
      ),
    );
  }

  ListTile _buildInfoTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onEdit,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.softblue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      trailing: onEdit != null
          ? IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: onEdit,
            )
          : null,
    );
  }

  Widget _buildSignOutButton(BuildContext context, AuthService authService) {
    return ElevatedButton.icon(
      onPressed: () async {
        await authService.signOut();
        if (context.mounted) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
        }
      },
      icon: const Icon(Icons.logout),
      label: const Text('Sign Out'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
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

  Future<void> _showEditDialog(
    BuildContext context,
    String title,
    String initialValue,
    Function(String) onSave,
  ) async {
    final controller = TextEditingController(text: initialValue);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(controller: controller, autofocus: true),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
