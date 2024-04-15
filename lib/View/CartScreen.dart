import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/cartController.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Provider.of<CartController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: cartController.cart.length,
        itemBuilder: (context, index) {
          Product product = cartController.cart.keys.elementAt(index);
          Map<Variant, int> variants = cartController.cart[product]!;

          return ListTile(
            title: Text(product.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: variants.entries.map((entry) {
                Variant variant = entry.key;
                int quantity = entry.value;
                double totalPrice = variant.price * quantity;

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${variant.size} - ${variant.type} x $quantity'),
                      Text('INR $totalPrice'),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price: INR ${cartController.getTotalPrice()}',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/payment'); // Navigate to PaymentScreen
                },
                child: Text('Proceed to Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
