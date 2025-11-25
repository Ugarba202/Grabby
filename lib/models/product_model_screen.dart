import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModelScreens {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final List<String>? additionalImages;
  final String categoryId;
  final String categoryName;
  final String sellerId;
  final String sellerName;
  final double rating;
  final int reviewCount;
  final int? deliveryTime;
  final double? deliveryFee;
  bool isFavorite;

  ProductModelScreens({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.categoryId,
    required this.categoryName,
    required this.sellerId,
    required this.sellerName,
    this.additionalImages,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.deliveryTime,
    this.deliveryFee,
    this.isFavorite = false,
  });

  // Format delivery time
  String get formattedDeliveryTime {
    if (deliveryTime == null) return 'N/A';
    return '$deliveryTime mins';
  }

  // Format price
  String get formattedPrice {
    return 'N${price.toStringAsFixed(0)}';
  }

  // FROM JSON (Firestore → Dart object)
  factory ProductModelScreens.fromJson(Map<String, dynamic> json) {
    return ProductModelScreens(
      id: json['id'] as String? ?? '',
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      additionalImages: (json['additionalImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      sellerId: json['sellerId'] as String,
      sellerName: json['sellerName'] as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      deliveryTime: json['deliveryTime'] as int?,
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble(),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  // TO JSON (Dart object → Firestore)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = {
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'rating': rating,
      'reviewCount': reviewCount,
      'isFavorite': isFavorite,
      'createdAt': FieldValue.serverTimestamp(), // Firestore timestamp
    };

    if (additionalImages != null && additionalImages!.isNotEmpty) {
      jsonMap['additionalImages'] = additionalImages;
    }
    if (deliveryTime != null) {
      jsonMap['deliveryTime'] = deliveryTime;
    }
    if (deliveryFee != null) {
      jsonMap['deliveryFee'] = deliveryFee;
    }
    return jsonMap;
  }
}
