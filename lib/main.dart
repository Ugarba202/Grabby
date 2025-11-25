import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grabby_app/models/category_model.dart';
import 'package:grabby_app/data/restaurant_mock_data.dart';
import 'package:grabby_app/core/constant/app_routes.dart';
import 'package:grabby_app/core/constant/app_string.dart';
import 'package:grabby_app/core/themes/app_theme.dart';
import 'package:grabby_app/features/enable_location_screen.dart';
import 'package:grabby_app/screens/auth/forgot_password.dart';
import 'package:grabby_app/screens/auth/login_screen.dart';
import 'package:grabby_app/screens/auth/registra_screen.dart';
import 'package:grabby_app/screens/auth/veriition_screen.dart';
import 'package:grabby_app/screens/home/category_screen.dart';
import 'package:grabby_app/screens/home/main_screen.dart';
import 'package:grabby_app/screens/home/profile_screen.dart';
import 'package:grabby_app/screens/location/location_permission.dart';
import 'package:grabby_app/screens/onboaring/widgets/account_activate_screen.dart';
import 'package:grabby_app/screens/onborading_screens.dart';
import 'package:grabby_app/screens/restaurants/home_screen.dart';
import 'models/product_model_screen.dart';
import 'models/restaurant_profile_model.dart';
import 'screens/category/categrory_screen.dart';
import 'screens/home/favorite_screen.dart';
import 'screens/home/shoping_cart_screen.dart';
import 'screens/menu/menu_items_details_screen.dart';
import 'screens/products/product_details_screen.dart';
import 'screens/restaurant_profile_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'services/storage_service.dart';

/// A one-time function to upload mock data to Firestore.
/// Run the app once with this, then remove the call in main().
Future<void> uploadMockData() async {
  final firestore = FirebaseFirestore.instance;
  final restaurants = SampleData.getRestaurants();
  final batch = firestore.batch();

  // --- 1. Process and Upload Restaurants ---
  for (final restaurant in restaurants) {
    final restaurantRef = firestore
        .collection('restaurants')
        .doc(restaurant.id);
    batch.set(restaurantRef, restaurant.toJson());
  }
  debugPrint('Restaurants prepared for batch upload.');

  // --- 2. Process and Upload Products (from MenuItems) and Categories ---
  final Set<String> categoryNames = {};
  for (final restaurant in restaurants) {
    for (final menuItem in restaurant.menuItems) {
      // Add category to a set to ensure uniqueness
      categoryNames.add(menuItem.category);

      // Convert MenuItem to ProductModelScreens
      final product = ProductModelScreens(
        id: '${restaurant.id}_${menuItem.id}', // Create a unique product ID
        name: menuItem.name,
        description: menuItem.description,
        price: menuItem.price.toDouble(),
        image: menuItem.imageUrl,
        categoryId: menuItem.category.toLowerCase().replaceAll(' ', '_'),
        categoryName: menuItem.category,
        sellerId: restaurant.id,
        sellerName: restaurant.name,
        rating: restaurant.rating, // Inherit rating from restaurant for now
        reviewCount: restaurant.reviewCount,
        deliveryTime: int.tryParse(restaurant.deliveryTime.split('-')[0]),
        deliveryFee: restaurant.deliveryFee.toDouble(),
        isFavorite: menuItem.isFavorite,
      );

      final productRef = firestore.collection('products').doc(product.id);
      batch.set(productRef, product.toJson());
    }
  }
  debugPrint('Products prepared for batch upload.');

  // --- 3. Create Category Documents ---
  for (final categoryName in categoryNames) {
    final categoryId = categoryName.toLowerCase().replaceAll(' ', '_');
    final category = CategoryModel(
      id: categoryId,
      name: categoryName,
      icon: 'assets/icons/default_category.png', // Placeholder icon
      decs: 'Delicious $categoryName',
    );
    final categoryRef = firestore.collection('categories').doc(categoryId);
    batch.set(categoryRef, category.toJson());
  }
  debugPrint('Categories prepared for batch upload.');

  try {
    await batch.commit();
    debugPrint(
      '✅ Successfully uploaded Restaurants, Products, and Categories!',
    );
  } catch (e) {
    debugPrint('❌ Error uploading mock data: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage service
  await StorageService.instance.init();

  await Firebase.initializeApp();

  // TODO: Run this once to upload data, then REMOVE this line.
  await uploadMockData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => const RegisterScreen(),
        AppRoutes.forgotPassword: (context) => const ForgotPasswordScreen(),
        AppRoutes.activateAccount: (context) => const AccountActivatedScreen(),
        AppRoutes.enableLocation: (context) => const EnableLocationScreen(),
        AppRoutes.main_screen: (context) => const MainScreen(),
        AppRoutes.categories: (context) => const CategoriesScreen(),
        AppRoutes.locationscreen: (context) => const LocationPermissionScreen(),
        AppRoutes.verification: (context) {
          // Get email from arguments
          final email = ModalRoute.of(context)?.settings.arguments as String?;
          return VerificationScreen(email: email);
        },
        AppRoutes.categorysecreen: (context) => const CategoriesScreen(),
        AppRoutes.profile_screen: (context) => const ProfileScreen(),
        AppRoutes.favorite_screen: (context) => const FavoriteScreen(),
        AppRoutes.shopingCart: (context) => const ShoppingCartScreen(),
        AppRoutes.home_screen: (context) => const HomeScreen(),
        AppRoutes.cart_screen: (context) => ShoppingCartScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.restaurant_profile) {
          final restaurant = settings.arguments as RestaurantProfileModel;
          return MaterialPageRoute(
            builder: (context) =>
                RestaurantProfileScreen(restaurant: restaurant),
          );
        }

        if (settings.name == AppRoutes.maincategory_screen) {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (context) => CategoryScreen(
              categoryId: args['categoryId']!,
              categoryName: args['categoryName']!,
            ),
          );
        }
        if (settings.name == AppRoutes.productDetail) {
          final product = settings.arguments as ProductModelScreens;
          return MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          );
        }
        if (settings.name == AppRoutes.menuItemDetails) {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => MenuItemDetailScreen(
              menuItem: args['menuItem'] as MenuItem,
              restaurantName: args['restaurantName'] as String,
              restaurantId: args['restaurantId'] as String?,
              deliveryTime: args['deliveryTime'] as int?,
              deliveryFee: args['deliveryFee'] as double?,
            ),
          );
        }
        return null;
      },
    );
  }
}
