import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../controller/order_controller.dart';
import '../controller/cartController.dart'; // Import CartController if not already imported

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Provider.of<OrderController>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Chocolate Order'),
        backgroundColor: Colors.pink,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];
          return _buildProductCard(context, orderController, product);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSummaryDialog(context, orderController);
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }

  Widget _buildProductCard(
      BuildContext context,
      OrderController orderController,
      Product product,
      ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.black,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: product.variants.map((variant) {
                int quantity = orderController.getQuantity(product, variant);
                double totalPrice = variant.price * quantity;

                return GestureDetector(
                  onTap: () {
                    _showQuantityDialog(
                        context, orderController, product, variant, quantity);
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/dairyMilk.jpg', // Replace 'assets/dairyMilk.png' with your actual image asset path
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${variant.size} - ${variant.type}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Price: INR ${variant.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Quantity: $quantity',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Total: INR $totalPrice',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showQuantityDialog(
      BuildContext context,
      OrderController orderController,
      Product product,
      Variant variant,
      int currentQuantity,
      ) {
    int newQuantity = currentQuantity;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adjust Quantity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (newQuantity > 0) {
                        newQuantity--;
                      }
                    },
                  ),
                  Text(
                    '$newQuantity',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      newQuantity++;
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                orderController.addToCart(
                  product,
                  variant,
                  newQuantity - currentQuantity,
                );
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showSummaryDialog(
      BuildContext context,
      OrderController orderController,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Summary'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: orderController.cart.length,
              itemBuilder: (context, index) {
                Product product = orderController.cart.keys.elementAt(index);
                Map<Variant, int> variants = orderController.cart[product]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: variants.entries.map((entry) {
                        Variant variant = entry.key;
                        int quantity = entry.value;
                        return ListTile(
                          title: Text('${variant.size} - ${variant.type}'),
                          subtitle: Text('Quantity: $quantity'),
                        );
                      }).toList(),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/payment'); // Navigate to CartScreen
              },
              child: Text('Proceed to Payment'),
            ),
          ],
        );
      },
    );
  }
}
