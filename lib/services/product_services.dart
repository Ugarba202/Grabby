import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/product_model_screen.dart';

class ProductService extends ChangeNotifier {
  static final ProductService _instance = ProductService._internal();
  factory ProductService() => _instance;
  ProductService._internal();
  static ProductService get instance => _instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Cache for products (to avoid repeated fetches)
  List<ProductModelScreens> _allProducts = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<ProductModelScreens> get allProducts => _allProducts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // ============================================================================
  // FETCH ALL PRODUCTS
  // ============================================================================
  Future<List<ProductModelScreens>> getAllProducts() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      print('📦 Fetching all products from Firestore...');

      final snapshot = await _firestore.collection('products').get();

      _allProducts = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Add document ID to data
        return ProductModelScreens.fromJson(data);
      }).toList();

      print('✅ Fetched ${_allProducts.length} products');

      _isLoading = false;
      notifyListeners();

      return _allProducts;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      print('❌ Error fetching products: $e');
      // Rethrow the exception to be handled by the UI
      rethrow;
    }
  }

  // ============================================================================
  // FETCH PRODUCTS BY CATEGORY
  // ============================================================================
  Future<List<ProductModelScreens>> getProductsByCategory(
    String categoryId,
  ) async {
    try {
      print('📦 Fetching products for category: $categoryId');

      final snapshot = await _firestore
          .collection('products')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      final products = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return ProductModelScreens.fromJson(data);
      }).toList();

      print('✅ Found ${products.length} products in $categoryId');
      return products;
    } catch (e) {
      print('❌ Error fetching products by category: $e');
      return [];
    }
  }

  // ============================================================================
  // FETCH SINGLE PRODUCT BY ID
  // ============================================================================
  Future<ProductModelScreens?> getProductById(String productId) async {
    try {
      print('📦 Fetching product: $productId');

      final doc = await _firestore.collection('products').doc(productId).get();

      if (!doc.exists) {
        print('❌ Product not found');
        return null;
      }

      final data = doc.data()!;
      data['id'] = doc.id;

      return ProductModelScreens.fromJson(data);
    } catch (e) {
      print('❌ Error fetching product: $e');
      return null;
    }
  }

  // ============================================================================
  // SEARCH PRODUCTS
  // ============================================================================
  Future<List<ProductModelScreens>> searchProducts(String query) async {
    try {
      if (query.isEmpty) return _allProducts;

      print('🔍 Searching for: $query');

      // If not cached, fetch all first
      if (_allProducts.isEmpty) {
        await getAllProducts();
      }

      // Filter locally (Firestore doesn't support text search well)
      final results = _allProducts.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.description.toLowerCase().contains(query.toLowerCase());
      }).toList();

      print('✅ Found ${results.length} results');
      return results;
    } catch (e) {
      print('❌ Error searching products: $e');
      return [];
    }
  }

  // ============================================================================
  // ADD PRODUCT (Admin function)
  // ============================================================================
  Future<bool> addProduct(ProductModelScreens product) async {
    try {
      print('➕ Adding product: ${product.name}');

      final docRef = await _firestore
          .collection('products')
          .add(product.toJson());

      print('✅ Product added successfully');

      // Add to local cache to avoid re-fetching all products
      // Create a new ProductModelScreens instance that includes the generated doc ID
      final productWithId = ProductModelScreens.fromJson({
        ...product.toJson(),
        'id': docRef.id,
      });
      _allProducts.add(productWithId);
      notifyListeners();

      return true;
    } catch (e) {
      print('❌ Error adding product: $e');
      return false;
    }
  }

  // ============================================================================
  // UPDATE PRODUCT (Admin function)
  // ============================================================================
  Future<bool> updateProduct(
    String productId,
    Map<String, dynamic> updates,
  ) async {
    try {
      print('✏️ Updating product: $productId');

      await _firestore.collection('products').doc(productId).update(updates);

      print('✅ Product updated successfully');

      // Update in local cache
      final index = _allProducts.indexWhere((p) => p.id == productId);
      if (index != -1) {
        // For a full refresh of the object, you might need to fetch it again
        // or apply the updates to the local model.
        // For simplicity, we'll just refetch all for now, but direct update is better.
        await getAllProducts(); // Or update _allProducts[index] manually
      }

      return true;
    } catch (e) {
      print('❌ Error updating product: $e');
      return false;
    }
  }

  // ============================================================================
  // DELETE PRODUCT (Admin function)
  // ============================================================================
  Future<bool> deleteProduct(String productId) async {
    try {
      print('🗑️ Deleting product: $productId');

      await _firestore.collection('products').doc(productId).delete();

      print('✅ Product deleted successfully');

      // Remove from local cache
      _allProducts.removeWhere((p) => p.id == productId);
      notifyListeners();

      return true;
    } catch (e) {
      print('❌ Error deleting product: $e');
      return false;
    }
  }

  // ============================================================================
  // REAL-TIME PRODUCT STREAM (Optional - for live updates)
  // ============================================================================
  Stream<List<ProductModelScreens>> getProductsStream() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return ProductModelScreens.fromJson(data);
      }).toList();
    });
  }

  // ============================================================================
  // CLEAR CACHE
  // ============================================================================
  void clearCache() {
    _allProducts = [];
    notifyListeners();
  }
}
