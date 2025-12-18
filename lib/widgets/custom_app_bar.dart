import 'package:flutter/material.dart';
import '../core/constant/app_colors.dart';
import 'package:provider/provider.dart';
import '../services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For GeoPoint

class CustomAppBar extends StatelessWidget {
  final VoidCallback? onNotificationPressed;

  const CustomAppBar({super.key, this.onNotificationPressed});

  // Helper to get first name from a full name string
  String _getFirstName(String? fullName) {
    if (fullName == null || fullName.isEmpty) {
      return 'Guest';
    }
    return fullName.split(' ').first;
  }

  // Helper to format GeoPoint location into a displayable string
  String _formatLocation(GeoPoint? location) {
    if (location == null) {
      return 'Location not set';
    }
    // For a more user-friendly display, you would typically reverse geocode
    // these coordinates to a human-readable address (e.g., "Lagos, Nigeria").
    // This would involve using a geocoding package or API.
    // For now, we display the coordinates.
    return 'Lat: ${location.latitude.toStringAsFixed(2)}, Lon: ${location.longitude.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final userService = context.watch<UserService>();
    final userProfile = userService.userProfile;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ), // Horizontal padding removed so it aligns with parent padding
      child: Column(
        children: [
          // 🔹 Top Row: Profile + Notification
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 👤 Profile Section
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    // Use NetworkImage if a profile picture URL is available, otherwise a default asset
                    backgroundImage:
                        userProfile?.profilePictureUrl != null &&
                            userProfile!.profilePictureUrl!.isNotEmpty
                        ? NetworkImage(userProfile.profilePictureUrl!)
                              as ImageProvider<Object>?
                        : const AssetImage(
                            'assets/images/default_avatar.png',
                          ), // Fallback to a default avatar asset
                  ),
                  const SizedBox(width: 14),
                  Text(
                    'Hello, ${_getFirstName(userProfile?.name)}', // Dynamic welcome text
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),

              // 🔔 Notification Button
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                color: AppColors.textPrimary,
                onPressed: onNotificationPressed,
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 📍 Location Row
          Row(
            children: [
              Icon(Icons.location_on, size: 22, color: AppColors.textPrimary),
              const SizedBox(width: 6),
              Text(
                // Dynamic location display
                _formatLocation(userProfile?.location),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
