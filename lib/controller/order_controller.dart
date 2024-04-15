import 'package:flutter/foundation.dart';
import '../models/product.dart';
import './CartController.dart';

class OrderController extends ChangeNotifier {
  final CartController _cartController = CartController();

  // Add item to cart
  void addToCart(Product product, Variant variant, int quantity) {
    if (quantity > 0) {
      _cartController.addToCart(product, variant, quantity);
      notifyListeners();
    }
  }

  // Remove item from cart
  void removeFromCart(Product product, Variant variant) {
    _cartController.removeFromCart(product, variant);
    notifyListeners();
  }

  // Get total price of items in cart
  double getTotalPrice() {
    return _cartController.getTotalPrice();
  }

  // Get quantity of a specific product variant in cart
  int getQuantity(Product product, Variant variant) {
    return _cartController.getQuantity(product, variant);
  }

  // Get cart items
  Map<Product, Map<Variant, int>> get cart => _cartController.cart;
}
