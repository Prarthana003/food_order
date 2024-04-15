import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/cartController.dart'; // Import your CartController

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Provider.of<CartController>(context);

    // Calculate total price from cart items
    double totalPrice = cartController.getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Amount:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'INR 240',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Implement payment logic here
                // This could involve integrating with a payment gateway or completing the purchase
                // For now, let's assume a simple confirmation
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Payment Successful'),
                      content: Text('Thank you for your purchase!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            cartController.clearCart(); // Clear cart after payment
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}
