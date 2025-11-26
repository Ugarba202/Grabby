import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:grabby_app/core/constant/app_routes.dart';
import 'package:grabby_app/services/favorite_service.dart';
import 'package:grabby_app/widgets/custom_product_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use a Consumer to listen to changes in FavoriteService
    return Consumer<FavoriteService>(
      builder: (context, favoriteService, child) {
        final favorites = favoriteService.favorites;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              'My Favorites',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              if (favorites.isNotEmpty)
                IconButton(
                  icon: const Icon(
                    Icons.delete_sweep_outlined,
                    color: Colors.red,
                  ),
                  onPressed: () => _showClearFavoritesDialog(context),
                ),
            ],
          ),
          body: favorites.isEmpty
              ? _buildEmptyState(context)
              : _buildFavoritesGrid(context, favorites),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 100, color: Colors.grey[300]),
          const SizedBox(height: 24),
          Text(
            'No Favorites Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the heart icon on any item to save it here.',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesGrid(BuildContext context, List<dynamic> favorites) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final product = favorites[index];
        return ProductCard(
          product: product,
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.productDetail,
              arguments: product,
            );
          },
        );
      },
    );
  }

  void _showClearFavoritesDialog(BuildContext context) {
    // Show a confirmation dialog before clearing all favorites
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Favorites?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              FavoriteService.instance.clearFavorites();
              Navigator.pop(context);
            },
            child: const Text('Clear All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
