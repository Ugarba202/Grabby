import 'package:grabby_app/core/constant/app_images.dart';

import '../models/restaurant_profile_model.dart';

class SampleData {
  static List<RestaurantProfileModel> getRestaurants() {
    return [
      getCactusRestaurant(),
      getOceanBasketRestaurant(),
      getChickenRepublicRestaurant(),
      get5GRestaurant(),
    ];
  }

  // Private method to create Cactus Restaurant
  static RestaurantProfileModel getCactusRestaurant() {
    return RestaurantProfileModel(
      id: '1',
      name: 'Cactus Restaurant ',
      description: 'International, Vegetarian Friendly, Vegan Options',

      imagePath:
          'https://storage.googleapis.com/your-project.appspot.com/images/restau1.png', // <-- PASTE URL HERE
      rating: 4.5,
      reviewCount: 281,
      deliveryTime: '30-45 min',
      deliveryFee: 200,
      cuisines: [
        'Barbecue',
        'Chinese & Thai',
        'European Ice Cream',
        'Pastries',
      ],

      // Menu Items for Cactus
      menuItems: [
        MenuItem(
          id: '1',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 3000,
          imageUrl: AppImages.menu1,
          category: 'Breakfast',
          isFavorite: true,
        ),
        MenuItem(
          id: '2',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 2500,
          imageUrl: AppImages.menu2,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '3',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 4000,
          imageUrl: AppImages.menu3,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '4',
          name: 'Iona pasta special',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 4500,
          imageUrl: AppImages.menu4,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '5',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 1200,
          imageUrl: AppImages.menu5,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '6',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 2200,
          imageUrl: AppImages.menu6,
          category: 'Breakfast',
          isFavorite: true,
        ),
        MenuItem(
          id: '7',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 3000,
          imageUrl: AppImages.menu7,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '8',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 12200,
          imageUrl: AppImages.menu8,
          category: 'Breakfast',
        ),

        MenuItem(
          id: '1',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 10000,
          imageUrl: AppImages.menu1,
          category: 'Dinner',
        ),
        MenuItem(
          id: '2',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu2,
          category: 'Dinner',
          isFavorite: true,
        ),
        MenuItem(
          id: '3',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu3,
          category: 'Dinner',
        ),
        MenuItem(
          id: '4',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu4,
          category: 'Dinner',
        ),
        MenuItem(
          id: '5',
          name: 'Iona pasta special',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu5,
          category: 'Dinner',
        ),
        MenuItem(
          id: '6',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu6,
          category: 'Dinner',
        ),
        MenuItem(
          id: '7',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu7,
          category: 'Dinner',
          isFavorite: true,
        ),
        MenuItem(
          id: '8',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu8,
          category: 'Dinner',
        ),

        MenuItem(
          id: '9',
          name: 'Iona pasta special',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu2,
          category: 'Dinner',
        ),
        MenuItem(
          id: '10',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu3,
          category: 'Dinner',
        ),
        MenuItem(
          id: '1',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu4,
          category: 'Lunch',
          isFavorite: true,
        ),
        MenuItem(
          id: '2',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu5,
          category: 'Lunch',
        ),
        MenuItem(
          id: '3',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu6,
          category: 'Lunch',
        ),
        MenuItem(
          id: '4',
          name: 'Iona pasta special',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu7,
          category: 'Lunch',
        ),
        MenuItem(
          id: '5',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu8,
          category: 'Lunch',
        ),
        MenuItem(
          id: '6',
          name: 'Lunch Special A',
          description: 'A delicious and quick lunch option.',
          price: 250,
          imageUrl: AppImages.menu1,
          category: 'Lunch',
        ),
        MenuItem(
          id: '7',
          name: 'Healthy Lunch Bowl',
          description: 'Packed with fresh vegetables and protein.',
          price: 300,
          imageUrl: AppImages.menu2,
          category: 'Lunch',
          isFavorite: true,
        ),
        MenuItem(
          id: '8',
          name: 'Club Sandwich',
          description: 'Classic triple-decker sandwich.',
          price: 220,
          imageUrl: AppImages.menu3,
          category: 'Lunch',
        ),
        MenuItem(
          id: '9',
          name: 'Spicy Noodle Soup',
          description: 'A warming and flavorful noodle soup for lunch.',
          price: 280,
          imageUrl: AppImages.menu4,
          category: 'Lunch',
        ),
        MenuItem(
          id: '10',
          name: 'Grilled Chicken Salad',
          description:
              'Light and refreshing salad with grilled chicken breast.',
          price: 260,
          imageUrl: AppImages.menu5,
          category: 'Lunch',
        ),
      ],

      // Restaurant Details
      details: RestaurantDetails(
        fullDescription:
            '''Cactus Restaurant was awarded itself as the go to restaurant for healthy, easy-to-eat takeout. Get started with Lagos & Central Lagos at Noon 247, Open.

The restaurant offers a great view of the Lagos Lagoon from its terrace, making it a great place for a romantic date, family outing or a group hang out.

The Cactus menu offers a wide variety of meals including pizza, meatball and chicken dishes. The dessert menu is made up of delicious home-made ice cream, cup cakes and other sorts of goodies. What more? Cactus restaurant has a friendly, trained staff ensuring great customer service.''',
        address:
            '23/7A, Ogunika Miadeke Street, Victoria Island, Lagos, Lagos State, Nigeria',
        phone: '+234 1 461 7880',
        openingHours: '07:00 AM - 9:00 PM',
        deliveryTime: '30-60mins',
        deliveryLocation: 'N2,500 - Lagos Mainland and Island',
        paymentModes: ['Credit Card', 'Debit Card/ Crypto Coins'],
        services: ['Breakfast Lunch and Dinner'],
      ),

      // Reviews for Cactus
      reviews: [
        Review(
          id: '1',
          userName: 'Monsour Dascot',
          userAvatar: AppImages.rev1,
          rating: 4.0,
          comment:
              'The restaurant is nice, the food is good and the servers are really polite. However, the meals are pretty expensive. I wish this could be considered. If it will cost the same or less than what others are selling soft and hot, that would be great for everyone.',
          timeAgo: '4 Days ago',
        ),
        Review(
          id: '2',
          userName: 'Ogunkan Olayide',
          userAvatar: AppImages.rev2,
          rating: 5.0,
          comment:
              'I have known cactus all the years that I have tried, worked and come to eat. There is nothing short of amazing. And on top of that all very affordable. The owners are always on hand to help with my children. I have eaten there many times during the years. They never disappoint.',
          timeAgo: '1 Weeks ago',
          images: [
            AppImages.menu1,
            AppImages.menu2,
            AppImages.menu3,
            AppImages.menu4,
          ],
        ),
        Review(
          id: '3',
          userName: 'Fike Ogunlana',
          userAvatar: AppImages.rev3,
          rating: 5.0,
          comment:
              'My family and I have always had a good time eating out here and we enjoyed how perfect their food tastes every time we visit. Food is fresh and flavourful. Portion is very generous and prices are great.',
          timeAgo: '3 Days ago',
        ),
        Review(
          id: '1',
          userName: 'Monsour Dascot',
          userAvatar: AppImages.rev2,
          rating: 4.0,
          comment:
              'The restaurant is nice, the food is good and the servers are really polite. However, the meals are pretty expensive. I wish this could be considered. If it will cost the same or less than what others are selling soft and hot, that would be great for everyone.',
          timeAgo: '4 Days ago',
        ),
      ],
      isOPen: true,
    );
  }

  // Create Ocean Basket Restaurant
  static RestaurantProfileModel getOceanBasketRestaurant() {
    return RestaurantProfileModel(
      id: '2',
      name: 'Ocean Basket',
      description: 'Fresh seafood restaurant',

      imagePath: AppImages.restau2,
      rating: 4.2,
      reviewCount: 156,
      deliveryTime: '25-40 min',
      deliveryFee: 150,
      cuisines: ['Seafood', 'Mediterranean', 'Grills'],
      menuItems: [
        MenuItem(
          id: '1',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu1,
          category: 'Breakfast',
          isFavorite: true,
        ),
        MenuItem(
          id: '2',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu2,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '3',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu3,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '4',
          name: 'Iona pasta special',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu4,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '5',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu5,
          category: 'BreakFast',
        ),
        MenuItem(
          id: '6',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu6,
          category: 'Breakfast',
          isFavorite: true,
        ),
        MenuItem(
          id: '7',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu7,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '8',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu8,
          category: 'Breakfast',
        ),

        MenuItem(
          id: '1',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu1,
          category: 'Dinner',
        ),
        MenuItem(
          id: '2',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu2,
          category: 'Dinner',
          isFavorite: true,
        ),
        MenuItem(
          id: '3',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu3,
          category: 'Dinner',
        ),
        MenuItem(
          id: '4',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu4,
          category: 'Dinner',
        ),
        MenuItem(
          id: '5',
          name: 'Iona pasta special',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu5,
          category: 'Dinner',
        ),
        MenuItem(
          id: '6',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu6,
          category: 'Dinner',
        ),
        MenuItem(
          id: '7',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu7,
          category: 'Dinner',
          isFavorite: true,
        ),
        MenuItem(
          id: '8',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu8,
          category: 'Dinner',
        ),
        MenuItem(
          id: '1',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu1,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '2',
          name: 'Iona pasta special',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu2,
          category: 'Dinner',
        ),
        MenuItem(
          id: '3',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu3,
          category: 'Dinner',
        ),
        MenuItem(
          id: '4',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu4,
          category: 'Breakfast',
          isFavorite: true,
        ),
        MenuItem(
          id: '5',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu5,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '6',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu6,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '7',
          name: 'Iona pasta special',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu7,
          category: 'Dinner',
        ),
        MenuItem(
          id: '8',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu8,
          category: 'Dinner',
        ),
        MenuItem(
          id: '1',
          name: 'Lunch Special A',
          description: 'A delicious and quick lunch option.',
          price: 250,
          imageUrl: AppImages.menu1,
          category: 'Lunch',
        ),
        MenuItem(
          id: '2',
          name: 'Healthy Lunch Bowl',
          description: 'Packed with fresh vegetables and protein.',
          price: 300,
          imageUrl: AppImages.menu2,
          category: 'Lunch',
          isFavorite: true,
        ),
        MenuItem(
          id: '3',
          name: 'Club Sandwich',
          description: 'Classic triple-decker sandwich.',
          price: 220,
          imageUrl: AppImages.menu3,
          category: 'Lunch',
        ),
        MenuItem(
          id: '4',
          name: 'Spicy Noodle Soup',
          description: 'A warming and flavorful noodle soup for lunch.',
          price: 280,
          imageUrl: AppImages.menu4,
          category: 'Lunch',
        ),
        MenuItem(
          id: '5',
          name: 'Grilled Chicken Salad',
          description:
              'Light and refreshing salad with grilled chicken breast.',
          price: 260,
          imageUrl: AppImages.menu5,
          category: 'Lunch',
        ),
      ],
      details: RestaurantDetails(
        fullDescription:
            'Ocean Basket brings you the freshest seafood in Lagos.',
        address: '15 Admiralty Way, Lekki Phase 1, Lagos',
        phone: '+234 1 234 5678',
        openingHours: '10:00 AM - 10:00 PM',
        deliveryTime: '25-40mins',
        deliveryLocation: 'N1,500 - Lagos Island',
        paymentModes: ['Cash', 'Card', 'Transfer'],
        services: ['Lunch', 'Dinner'],
      ),
      reviews: [
        Review(
          id: '1',
          userName: 'Monsour Dascot',
          userAvatar: AppImages.rev1,
          rating: 4.0,
          comment:
              'The restaurant is nice, the food is good and the servers are really polite. However, the meals are pretty expensive. I wish this could be considered. If it will cost the same or less than what others are selling soft and hot, that would be great for everyone.',
          timeAgo: '4 Days ago',
        ),
        Review(
          id: '2',
          userName: 'Ogunkan Olayide',
          userAvatar: AppImages.rev2,
          rating: 5.0,
          comment:
              'I have known cactus all the years that I have tried, worked and come to eat. There is nothing short of amazing. And on top of that all very affordable. The owners are always on hand to help with my children. I have eaten there many times during the years. They never disappoint.',
          timeAgo: '1 Weeks ago',
          images: [
            AppImages.menu1,
            AppImages.menu2,
            AppImages.menu3,
            AppImages.menu4,
          ],
        ),
        Review(
          id: '3',
          userName: 'Fike Ogunlana',
          userAvatar: AppImages.rev3,
          rating: 5.0,
          comment:
              'My family and I have always had a good time eating out here and we enjoyed how perfect their food tastes every time we visit. Food is fresh and flavourful. Portion is very generous and prices are great.',
          timeAgo: '3 Days ago',
        ),
        Review(
          id: '1',
          userName: 'Monsour Dascot',
          userAvatar: AppImages.rev2,
          rating: 4.0,
          comment:
              'The restaurant is nice, the food is good and the servers are really polite. However, the meals are pretty expensive. I wish this could be considered. If it will cost the same or less than what others are selling soft and hot, that would be great for everyone.',
          timeAgo: '4 Days ago',
        ),
      ],
      isOPen: true,
    );
  }

  // Create Chicken Republic Restaurant
  static RestaurantProfileModel getChickenRepublicRestaurant() {
    return RestaurantProfileModel(
      id: '3',
      name: 'Chicken Republic',
      description: 'Fast food chain with African flavors',

      imagePath: AppImages.restau3,
      rating: 4.7,
      reviewCount: 432,
      deliveryTime: '20-30 min',
      deliveryFee: 100,
      cuisines: ['Fast Food', 'African', 'Chicken'],
      menuItems: [
        MenuItem(
          id: '1',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu1,
          category: 'Breakfast',
          isFavorite: true,
        ),
        MenuItem(
          id: '2',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu2,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '3',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu3,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '4',
          name: 'Iona pasta special',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu4,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '5',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu5,
          category: 'BreakFast',
        ),
        MenuItem(
          id: '6',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu6,
          category: 'Breakfast',
          isFavorite: true,
        ),
        MenuItem(
          id: '7',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu7,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '8',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu8,
          category: 'Breakfast',
        ),

        MenuItem(
          id: '1',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu1,
          category: 'Dinner',
        ),
        MenuItem(
          id: '2',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu2,
          category: 'Dinner',
          isFavorite: true,
        ),
        MenuItem(
          id: '3',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu3,
          category: 'Dinner',
        ),
        MenuItem(
          id: '4',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu4,
          category: 'Dinner',
        ),
        MenuItem(
          id: '5',
          name: 'Iona pasta special',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu5,
          category: 'Dinner',
        ),
        MenuItem(
          id: '6',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu6,
          category: 'Dinner',
        ),
        MenuItem(
          id: '7',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu7,
          category: 'Dinner',
          isFavorite: true,
        ),
        MenuItem(
          id: '8',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu8,
          category: 'Dinner',
        ),
        MenuItem(
          id: '1',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu1,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '2',
          name: 'Iona pasta special',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu2,
          category: 'Dinner',
        ),
        MenuItem(
          id: '3',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu3,
          category: 'Dinner',
        ),
        MenuItem(
          id: '4',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu4,
          category: 'Breakfast',
          isFavorite: true,
        ),
        MenuItem(
          id: '5',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu5,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '6',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu6,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '7',
          name: 'Iona pasta special',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu7,
          category: 'Dinner',
        ),
        MenuItem(
          id: '8',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu8,
          category: 'Dinner',
        ),
        MenuItem(
          id: '1',
          name: 'Lunch Special A',
          description: 'A delicious and quick lunch option.',
          price: 250,
          imageUrl: AppImages.menu1,
          category: 'Lunch',
        ),
        MenuItem(
          id: '2',
          name: 'Healthy Lunch Bowl',
          description: 'Packed with fresh vegetables and protein.',
          price: 300,
          imageUrl: AppImages.menu2,
          category: 'Lunch',
          isFavorite: true,
        ),
        MenuItem(
          id: '3',
          name: 'Club Sandwich',
          description: 'Classic triple-decker sandwich.',
          price: 220,
          imageUrl: AppImages.menu3,
          category: 'Lunch',
        ),
        MenuItem(
          id: '4',
          name: 'Spicy Noodle Soup',
          description: 'A warming and flavorful noodle soup for lunch.',
          price: 280,
          imageUrl: AppImages.menu4,
          category: 'Lunch',
        ),
        MenuItem(
          id: '5',
          name: 'Grilled Chicken Salad',
          description:
              'Light and refreshing salad with grilled chicken breast.',
          price: 260,
          imageUrl: AppImages.menu5,
          category: 'Lunch',
        ),
      ],
      details: RestaurantDetails(
        fullDescription:
            'Chicken Republic offers delicious African-inspired fast food.',
        address: '45 Allen Avenue, Ikeja, Lagos',
        phone: '+234 1 345 6789',
        openingHours: '08:00 AM - 11:00 PM',
        deliveryTime: '20-30mins',
        deliveryLocation: 'N800 - Lagos Mainland',
        paymentModes: ['Cash', 'Card', 'USSD'],
        services: ['Breakfast', 'Lunch', 'Dinner'],
      ),
      reviews: [
        Review(
          id: '1',
          userName: 'Monsour Dascot',
          userAvatar: AppImages.rev1,
          rating: 4.0,
          comment:
              'The restaurant is nice, the food is good and the servers are really polite. However, the meals are pretty expensive. I wish this could be considered. If it will cost the same or less than what others are selling soft and hot, that would be great for everyone.',
          timeAgo: '4 Days ago',
        ),
        Review(
          id: '2',
          userName: 'Ogunkan Olayide',
          userAvatar: AppImages.rev2,
          rating: 5.0,
          comment:
              'I have known cactus all the years that I have tried, worked and come to eat. There is nothing short of amazing. And on top of that all very affordable. The owners are always on hand to help with my children. I have eaten there many times during the years. They never disappoint.',
          timeAgo: '1 Weeks ago',
          images: [
            AppImages.menu1,
            AppImages.menu2,
            AppImages.menu3,
            AppImages.menu4,
          ],
        ),
        Review(
          id: '3',
          userName: 'Fike Ogunlana',
          userAvatar: AppImages.rev3,
          rating: 5.0,
          comment:
              'My family and I have always had a good time eating out here and we enjoyed how perfect their food tastes every time we visit. Food is fresh and flavourful. Portion is very generous and prices are great.',
          timeAgo: '3 Days ago',
        ),
        Review(
          id: '1',
          userName: 'Monsour Dascot',
          userAvatar: AppImages.rev2,
          rating: 4.0,
          comment:
              'The restaurant is nice, the food is good and the servers are really polite. However, the meals are pretty expensive. I wish this could be considered. If it will cost the same or less than what others are selling soft and hot, that would be great for everyone.',
          timeAgo: '4 Days ago',
        ),
      ],
      isOPen: true,
    );
  }

  static RestaurantProfileModel get5GRestaurant() {
    return RestaurantProfileModel(
      id: '3',
      name: ' 5G Restaurant',
      description: 'Fast food chain with African flavors',

      imagePath: AppImages.restau4,
      rating: 4.7,
      reviewCount: 432,
      deliveryTime: '20-30 min',
      deliveryFee: 100,
      cuisines: ['Fast Food', 'African', 'Chicken'],

      menuItems: [
        MenuItem(
          id: '1',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu1,
          category: 'Breakfast',
          isFavorite: true,
        ),
        MenuItem(
          id: '2',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu2,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '3',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu3,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '4',
          name: 'Iona pasta special',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu4,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '5',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu5,
          category: 'BreakFast',
        ),
        MenuItem(
          id: '6',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu6,
          category: 'Breakfast',
          isFavorite: true,
        ),
        MenuItem(
          id: '7',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu7,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '8',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu8,
          category: 'Breakfast',
        ),

        MenuItem(
          id: '1',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu1,
          category: 'Dinner',
        ),
        MenuItem(
          id: '2',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu2,
          category: 'Dinner',
          isFavorite: true,
        ),
        MenuItem(
          id: '3',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu3,
          category: 'Dinner',
        ),
        MenuItem(
          id: '4',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu4,
          category: 'Dinner',
        ),
        MenuItem(
          id: '5',
          name: 'Iona pasta special',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu5,
          category: 'Dinner',
        ),
        MenuItem(
          id: '6',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu6,
          category: 'Dinner',
        ),
        MenuItem(
          id: '7',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu7,
          category: 'Dinner',
          isFavorite: true,
        ),
        MenuItem(
          id: '8',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu8,
          category: 'Dinner',
        ),
        MenuItem(
          id: '1',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu1,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '2',
          name: 'Iona pasta special',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu2,
          category: 'Dinner',
        ),
        MenuItem(
          id: '3',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu3,
          category: 'Dinner',
        ),
        MenuItem(
          id: '4',
          name: 'Apple wood smoked chicken',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu4,
          category: 'Breakfast',
          isFavorite: true,
        ),
        MenuItem(
          id: '5',
          name: 'Sonerai pasta',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu5,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '6',
          name: 'Pork wabo finitas',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu6,
          category: 'Breakfast',
        ),
        MenuItem(
          id: '7',
          name: 'Iona pasta special',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu7,
          category: 'Dinner',
        ),
        MenuItem(
          id: '8',
          name: 'Iona every where',
          description:
              'It is a unique chicken with mushroom, onion, green pepper in red BBC sauce',
          price: 200,
          imageUrl: AppImages.menu8,
          category: 'Dinner',
        ),
        MenuItem(
          id: '1',
          name: 'Lunch Special A',
          description: 'A delicious and quick lunch option.',
          price: 250,
          imageUrl: AppImages.menu1,
          category: 'Lunch',
        ),
        MenuItem(
          id: '2',
          name: 'Healthy Lunch Bowl',
          description: 'Packed with fresh vegetables and protein.',
          price: 300,
          imageUrl: AppImages.menu2,
          category: 'Lunch',
          isFavorite: true,
        ),
        MenuItem(
          id: '3',
          name: 'Club Sandwich',
          description: 'Classic triple-decker sandwich.',
          price: 220,
          imageUrl: AppImages.menu3,
          category: 'Lunch',
        ),
        MenuItem(
          id: '4',
          name: 'Spicy Noodle Soup',
          description: 'A warming and flavorful noodle soup for lunch.',
          price: 280,
          imageUrl: AppImages.menu4,
          category: 'Lunch',
        ),
        MenuItem(
          id: '5',
          name: 'Grilled Chicken Salad',
          description:
              'Light and refreshing salad with grilled chicken breast.',
          price: 260,
          imageUrl: AppImages.menu5,
          category: 'Lunch',
        ),
      ],
      details: RestaurantDetails(
        fullDescription:
            'Chicken Republic offers delicious African-inspired fast food.',
        address: '45 Allen Avenue, Ikeja, Lagos',
        phone: '+234 1 345 6789',
        openingHours: '08:00 AM - 11:00 PM',
        deliveryTime: '20-30mins',
        deliveryLocation: 'N800 - Lagos Mainland',
        paymentModes: ['Cash', 'Card', 'USSD'],
        services: ['BreakFast', 'Lunch', 'Dinner'],
      ),
      reviews: [
        Review(
          id: '1',
          userName: 'Monsour Dascot',
          userAvatar: AppImages.rev1,
          rating: 4.0,
          comment:
              'The restaurant is nice, the food is good and the servers are really polite. However, the meals are pretty expensive. I wish this could be considered. If it will cost the same or less than what others are selling soft and hot, that would be great for everyone.',
          timeAgo: '4 Days ago',
        ),
        Review(
          id: '2',
          userName: 'Ogunkan Olayide',
          userAvatar: AppImages.rev2,
          rating: 5.0,
          comment:
              'I have known cactus all the years that I have tried, worked and come to eat. There is nothing short of amazing. And on top of that all very affordable. The owners are always on hand to help with my children. I have eaten there many times during the years. They never disappoint.',
          timeAgo: '1 Weeks ago',
          images: [
            AppImages.menu1,
            AppImages.menu2,
            AppImages.menu3,
            AppImages.menu4,
          ],
        ),
        Review(
          id: '3',
          userName: 'Fike Ogunlana',
          userAvatar: AppImages.rev3,
          rating: 5.0,
          comment:
              'My family and I have always had a good time eating out here and we enjoyed how perfect their food tastes every time we visit. Food is fresh and flavourful. Portion is very generous and prices are great.',
          timeAgo: '3 Days ago',
        ),
        Review(
          id: '1',
          userName: 'Monsour Dascot',
          userAvatar: AppImages.rev2,
          rating: 4.0,
          comment:
              'The restaurant is nice, the food is good and the servers are really polite. However, the meals are pretty expensive. I wish this could be considered. If it will cost the same or less than what others are selling soft and hot, that would be great for everyone.',
          timeAgo: '4 Days ago',
        ),
      ],
      isOPen: true,
    );
  }
}
