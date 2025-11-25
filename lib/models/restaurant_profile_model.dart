class RestaurantProfileModel {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final double rating;
  final int reviewCount;
  final bool isOPen;
  final List<String> cuisines;
  final List<MenuItem> menuItems;
  final RestaurantDetails details;
  final List<Review> reviews;
  final int deliveryFee;
  final String deliveryTime;

  RestaurantProfileModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.rating,
    required this.reviewCount,
    required this.isOPen,
    required this.menuItems,
    required this.details,
    required this.reviews,
    required this.deliveryFee,
    required this.deliveryTime,
    required this.cuisines,
  });

  // FROM JSON (Firestore -> Dart Object)
  factory RestaurantProfileModel.fromJson(Map<String, dynamic> json) {
    return RestaurantProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      isOPen: json['isOPen'] as bool,
      menuItems: (json['menuItems'] as List<dynamic>)
          .map((item) => MenuItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      details:
          RestaurantDetails.fromJson(json['details'] as Map<String, dynamic>),
      reviews: (json['reviews'] as List<dynamic>)
          .map((review) => Review.fromJson(review as Map<String, dynamic>))
          .toList(),
      deliveryFee: json['deliveryFee'] as int,
      deliveryTime: json['deliveryTime'] as String,
      cuisines: (json['cuisines'] as List<dynamic>).cast<String>(),
    );
  }

  // TO JSON (Dart Object -> Firestore)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'rating': rating,
      'reviewCount': reviewCount,
      'isOPen': isOPen,
      'cuisines': cuisines,
      'menuItems': menuItems.map((item) => item.toJson()).toList(),
      'details': details.toJson(),
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'deliveryFee': deliveryFee,
      'deliveryTime': deliveryTime,
    };
  }
}

// ============================================================================
// FILE: lib/models/menu_item.dart
// PURPOSE: Define the structure of a Menu Item
//
class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category; // e.g., "Breakfast", "Dinner"
  bool isFavorite;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isFavorite = false,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'isFavorite': isFavorite,
    };
  }
}

// ============================================================================
// FILE: lib/models/restaurant_details.dart
// PURPOSE: Define detailed information about a restaurant
// ============================================================================

class RestaurantDetails {
  final String fullDescription;
  final String address;
  final String phone;
  final String openingHours;
  final String deliveryTime;
  final String deliveryLocation;
  final List<String> paymentModes;
  final List<String> services;

  RestaurantDetails({
    required this.fullDescription,
    required this.address,
    required this.phone,
    required this.openingHours,
    required this.deliveryTime,
    required this.deliveryLocation,
    required this.paymentModes,
    required this.services,
  });

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) {
    return RestaurantDetails(
      fullDescription: json['fullDescription'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      openingHours: json['openingHours'] as String,
      deliveryTime: json['deliveryTime'] as String,
      deliveryLocation: json['deliveryLocation'] as String,
      paymentModes: (json['paymentModes'] as List<dynamic>).cast<String>(),
      services: (json['services'] as List<dynamic>).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullDescription': fullDescription,
      'address': address,
      'phone': phone,
      'openingHours': openingHours,
      'deliveryTime': deliveryTime,
      'deliveryLocation': deliveryLocation,
      'paymentModes': paymentModes,
      'services': services,
    };
  }
}

class Review {
  final String id;
  final String userName;
  final String userAvatar;
  final double rating;
  final String comment;
  final String timeAgo;
  final List<String> images;

  Review({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.comment,
    required this.timeAgo,
    this.images = const [],
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      userName: json['userName'] as String,
      userAvatar: json['userAvatar'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      timeAgo: json['timeAgo'] as String,
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userAvatar': userAvatar,
      'rating': rating,
      'comment': comment,
      'timeAgo': timeAgo,
      'images': images,
    };
  }
}
