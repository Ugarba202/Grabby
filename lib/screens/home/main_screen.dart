import 'package:flutter/material.dart';

import 'package:grabby_app/core/constant/app_routes.dart';
import 'package:grabby_app/core/constant/app_string.dart'; // This is the mock data for categories and products
import 'package:grabby_app/data/restaurant_mock_data.dart';
import 'package:grabby_app/models/category_model.dart';

import 'package:grabby_app/models/product_model.dart';
import 'package:grabby_app/models/restaurant_profile_model.dart';
import 'package:grabby_app/widgets/categries_section_header.dart';
import 'package:grabby_app/widgets/custom_bottom_nav_bar.dart';
import 'package:grabby_app/widgets/custom_category_section.dart';

import 'package:grabby_app/widgets/custom_app_bar.dart';
import 'package:grabby_app/widgets/custom_product_section.dart';
import 'package:grabby_app/widgets/custom_restaurant_section.dart';
import 'package:grabby_app/widgets/search_bar_widget.dart';

import '../../data/mock_data.dart';
import '../../core/constant/app_text_style.dart';
//import 'package:grabby_app/widgets/search_bar_widget.dart';

/// Main home screen of the app
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<MainScreen> {
  // Mock Data 
  final List<CategoryModel> categories = MockData.categories.take(12).toList();
  final List<ProductModel> products = MockData.products;
  final List<RestaurantProfileModel> restaurants = SampleData.getRestaurants();

  int _selectedIndex =
      0; // State to manage the current index of the bottom nav bar
  final Set<String> _favoriteProducts = {};
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onCategoryTap(CategoryModel category) {
    // TODO: Navigate to a screen showing products for the selected category
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped on ${category.name}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _onProductTap(ProductModel product) {
    // Handle navigation or details
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Tapped on ${product.name}')));
  }

  void _toggleFavorite(String productId) {
    setState(() {
      if (_favoriteProducts.contains(productId)) {
        _favoriteProducts.remove(productId);
      } else {
        _favoriteProducts.add(productId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 15;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(horizontalPadding),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 20),
                  CustomAppBar(
                    // Now fetches user data dynamically
                    onNotificationPressed: () {
                      // TODO: Implement notification screen navigation
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Notifications Tapped!')),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  SearchWithFilter(
                    controller: TextEditingController(),
                    hintText: AppStrings.searchBarhintText,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.restaurantText,
                    style: AppTextStyles.displaySmall,
                  ),
                  const SizedBox(height: 20),
                  CustomRestaurantSection(restaurants: restaurants),
                  const SizedBox(height: 20),
                  Text(
                    AppStrings.categoriesText,
                    style: AppTextStyles.displaySmall,
                  ),

                  const SizedBox(height: 20),
                  CustomCategorySection(
                    categories: categories,
                    onCategoryTap: onCategoryTap,
                  ),
                  SizedBox(height: 20),
                  CategoriesSectionHeader(
                    title: 'Recommended',
                    actionText: 'View all',
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.categories,
                    ),
                  ),

                  ProductSection(
                    products: products,
                    onProductTap: _onProductTap,
                    onFavoriteToggle: _toggleFavorite,
                    favoriteProducts: _favoriteProducts,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onItemSelected: onItemTapped,
      ),
    );
  }
}
