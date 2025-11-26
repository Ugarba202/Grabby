import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:grabby_app/models/restaurant_profile_model.dart';

class RestaurantService extends ChangeNotifier {
  static final RestaurantService _instance = RestaurantService._internal();
  factory RestaurantService() => _instance;
  RestaurantService._internal();
  static RestaurantService get instance => _instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Cache for restaurants
  List<RestaurantProfileModel> _restaurants = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<RestaurantProfileModel> get restaurants => _restaurants;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Fetches a list of all restaurants from Firestore.
  Future<List<RestaurantProfileModel>> getRestaurants() async {
    // Return cached data if available
    if (_restaurants.isNotEmpty) {
      return _restaurants;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      debugPrint('Fetching restaurants from Firestore...');
      final snapshot = await _firestore.collection('restaurants').get();
      if (snapshot.docs.isEmpty) {
        debugPrint('No restaurants found in Firestore.');
        return [];
      }
      _restaurants = snapshot.docs
          .map((doc) => RestaurantProfileModel.fromJson(doc.data()))
          .toList();
      debugPrint('✅ Fetched ${_restaurants.length} restaurants.');
      return _restaurants;
    } catch (e) {
      debugPrint('❌ Error fetching restaurants: $e');
      rethrow; // Rethrow to allow UI to handle the error
    }
  }
}
