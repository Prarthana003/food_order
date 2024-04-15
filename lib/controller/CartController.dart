import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartController extends ChangeNotifier {
  Map<Product, Map<Variant, int>> _cart = {};

  // Add item to cart
  void addToCart(Product product, Variant variant, int quantity) {
    if (_cart.containsKey(product)) {
      // If the product exists in the cart, update its variant quantity
      _cart[product]![variant] = (_cart[product]![variant] ?? 0) + quantity;
    } else {
      // If the product doesn't exist in the cart, add it with the variant and quantity
      _cart[product] = {variant: quantity};
    }

    notifyListeners(); // Notify listeners (e.g., UI) that the cart has been updated
  }

  // Remove item from cart
  void removeFromCart(Product product, Variant variant) {
    if (_cart.containsKey(product)) {
      _cart[product]?.remove(variant);

      if (_cart[product]?.isEmpty ?? true) {
        _cart.remove(product);
      }

      notifyListeners(); // Notify listeners (e.g., UI) that the cart has been updated
    }
  }

  // Get total price of items in cart
  double getTotalPrice() {
    double totalPrice = 0;
    _cart.forEach((product, variants) {
      variants.forEach((variant, quantity) {
        totalPrice += variant.price * quantity;
      });
    });
    return totalPrice;
  }

  // Get quantity of a specific product variant in cart
  int getQuantity(Product product, Variant variant) {
    if (_cart.containsKey(product) && _cart[product]!.containsKey(variant)) {
      return _cart[product]![variant]!;
    } else {
      return 0; // Return 0 if the product or variant is not found in the cart
    }
  }

  // Clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // Get cart items
  Map<Product, Map<Variant, int>> get cart => _cart;
}
