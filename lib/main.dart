import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/order_controller.dart';
import './controller/cartController.dart';
import 'view/cartScreen.dart';
import 'view/HomeScreen.dart';
import 'view/order_screen.dart';
import './view/paymentScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OrderController>(
          create: (_) => OrderController(),
        ),
        ChangeNotifierProvider<CartController>(
          create: (_) => CartController(),
        ),
      ],
      child: MaterialApp(
        title: 'My App',
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/order': (context) => OrderScreen(),
          '/cart': (context) => CartScreen(),
          '/payment': (context) => PaymentScreen(),
        },
      ),
    );
  }
}
