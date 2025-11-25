import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:grabby_app/models/category_model.dart';
import 'package:grabby_app/models/product_model_screen.dart';
import 'package:grabby_app/models/restaurant_profile_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetches a list of categories from Firestore.
  Future<List<CategoryModel>> getCategories() async {
    try {
      final snapshot = await _db.collection('categories').get();
      if (snapshot.docs.isEmpty) {
        debugPrint('No categories found in Firestore.');
        return [];
      }
      return snapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      debugPrint('Error fetching categories: $e');
      rethrow;
    }
  }

  /// Fetches a list of restaurants from Firestore.
  Future<List<RestaurantProfileModel>> getRestaurants() async {
    try { 
      final snapshot = await _db.collection('restaurants').get();
      if (snapshot.docs.isEmpty) {
        debugPrint('No restaurants found in Firestore.');
        return [];
      }
      return snapshot.docs
          .map((doc) => RestaurantProfileModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      debugPrint('Error fetching restaurants: $e');
      rethrow;
    }
  }

  // You can add more methods here to fetch other data, like products by category:
  Future<List<ProductModelScreens>> getProductsByCategory(
    String categoryId,
  ) async {
    try {
      final snapshot = await _db
          .collection('products')
          .where('categoryId', isEqualTo: categoryId)
          .get();
      return snapshot.docs
          .map((doc) => ProductModelScreens.fromJson(doc.data()))
          .toList();
    } catch (e) {
      debugPrint('Error fetching products for category $categoryId: $e');
      rethrow;
    }
  }
}
