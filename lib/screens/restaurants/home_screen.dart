// ============================================================================
// FILE: lib/screens/home_screen.dart
// PURPOSE: Display list of restaurants
// ============================================================================
import 'package:grabby_app/core/constant/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:grabby_app/models/restaurant_profile_model.dart';
import '../../widgets/restaurant_card.dart';
import '../../services/restaurant_service.dart';
import '../restaurant_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Future to hold the list of restaurants from Firestore
  late Future<List<RestaurantProfileModel>> _restaurantsFuture;

  @override
  void initState() {
    super.initState();
    // Fetch restaurants when the screen initializes
    _restaurantsFuture = RestaurantService.instance.getRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Restaurants',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Search button
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
          ),
          // Filter button
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              // TODO: Add filter functionality
              print('Filter tapped');
            },
          ),
        ],
      ),

      // Body - List of restaurants
      body: FutureBuilder<List<RestaurantProfileModel>>(
        future: _restaurantsFuture,
        builder: (context, snapshot) {
          // 1. Show a loading indicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2. Show an error message
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // 3. Show a message if no data is found
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No restaurants found.'));
          }
          // 4. Display the list of restaurants
          final restaurants = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return RestaurantCard(
                restaurant: restaurant,
                onTap: () {
                  _navigateToRestaurantProfile(restaurant);
                },
              );
            },
          );
        },
      ),
    );
  }

  // Method to navigate to restaurant profile
  void _navigateToRestaurantProfile(RestaurantProfileModel restaurant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantProfileScreen(
          restaurant: restaurant, // Pass the selected restaurant
        ),
      ),
    );
  }
}
