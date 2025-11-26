import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model_screen.dart';

class FavoriteService extends ChangeNotifier {
  static final FavoriteService _instance = FavoriteService._internal();
  factory FavoriteService() => _instance;
  FavoriteService._internal();
  static FavoriteService get instance => _instance;

  final List<ProductModelScreens> _favorites = [];
  static const String _favoritesKey = 'favorites';

  List<ProductModelScreens> get favorites => _favorites;

  /// Initializes the service by loading favorites from local storage.
  Future<void> init() async {
    await _loadFavorites();
  }

  /// Toggles the favorite status of a product.
  /// Adds the product to favorites if it's not already there,
  /// otherwise removes it.
  /// Returns `true` if the product was added, `false` if removed.
  Future<bool> toggleFavorite(ProductModelScreens product) async {
    final isCurrentlyFavorite = isFavorite(product.id);

    if (isCurrentlyFavorite) {
      _favorites.removeWhere((p) => p.id == product.id);
      await _saveFavorites();
      notifyListeners();
      return false;
    } else {
      _favorites.add(product);
      await _saveFavorites();
      notifyListeners();
      return true;
    }
  }

  /// Checks if a product is in the favorites list.
  bool isFavorite(String productId) {
    return _favorites.any((p) => p.id == productId);
  }

  /// Loads the list of favorite products from SharedPreferences.
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteData = prefs.getStringList(_favoritesKey);

    if (favoriteData != null) {
      _favorites.clear();
      for (var productJson in favoriteData) {
        try {
          final productMap = jsonDecode(productJson) as Map<String, dynamic>;
          _favorites.add(ProductModelScreens.fromJson(productMap));
        } catch (e) {
          debugPrint('Error decoding favorite item: $e');
        }
      }
      notifyListeners();
      debugPrint('✅ Loaded ${_favorites.length} favorites from storage.');
    }
  }

  /// Saves the current list of favorite products to SharedPreferences.
  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteData = _favorites
        .map((p) => jsonEncode(p.toJsonWithId()))
        .toList();
    await prefs.setStringList(_favoritesKey, favoriteData);
    debugPrint('💾 Saved ${_favorites.length} favorites to storage.');
  }

  /// Clears all favorites.
  Future<void> clearFavorites() async {
    _favorites.clear();
    await _saveFavorites();
    notifyListeners();
  }
}

extension ProductModelScreensSerialization on ProductModelScreens {
  /// A special toJson method that includes the ID, necessary for re-creating
  /// the object from shared preferences.
  Map<String, dynamic> toJsonWithId() {
    final json = toJson();
    json['id'] = id; // Ensure ID is included for deserialization
    return json;
  }
}
