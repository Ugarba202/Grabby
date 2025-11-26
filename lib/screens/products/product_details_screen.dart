import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constant/app_colors.dart';
import '../../models/product_model_screen.dart';
import '../../models/cart_item_model.dart';
import '../../services/cart_services.dart';
import '../../services/favorite_service.dart';
import '../home/shoping_cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModelScreens product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void _addToCart() {
    // 1. Create a CartItemModel from the product details
    final cartItem = CartItemModel(
      id: '${widget.product.id}_${DateTime.now().millisecondsSinceEpoch}',
      productId: widget.product.id,
      productName: widget.product.name,
      productImage: widget.product.image,
      basePrice: widget.product.price,
      quantity: quantity,
      restaurantName: widget.product.sellerName,
    );

    // 2. Add the item to the cart using the CartService
    CartService.instance.addItem(cartItem);

    // 3. Show a confirmation SnackBar with a "View Cart" action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.product.name} added to cart!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShoppingCartScreen(),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the FavoriteService instance from the provider
    final favoriteService = Provider.of<FavoriteService>(context);
    final isFavorite = favoriteService.isFavorite(widget.product.id);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // 1. Display product name in the AppBar
        title: Text(
          widget.product.name,
          style: const TextStyle(color: Colors.black, fontSize: 28),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () async {
              // Use the service to toggle the favorite status
              final wasAdded = await favoriteService.toggleFavorite(
                widget.product,
              );

              // Show a snackbar only if the item was added
              if (mounted && wasAdded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.product.name} added to favorites!'),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: Image.asset(
                      widget.product.image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image,
                          size: 100,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: _decrementQuantity,
                        color: AppColors.softblue,
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.softblue,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _incrementQuantity,
                        color: AppColors.softblue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // 3. Price, centered
                  Text(
                    widget.product.formattedPrice,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 4. Description, centered
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      widget.product.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.black,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // 5. Review and Time in a Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.product.rating.toStringAsFixed(1)} (${widget.product.reviewCount} reviews)',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 50),
                      const Icon(
                        Icons.access_time,
                        color: Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.product.formattedDeliveryTime,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _addToCart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.softblue,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
