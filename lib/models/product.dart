class Product {
  final String name;
  final List<Variant> variants;

  Product(this.name, this.variants);
}

class Variant {
  final String size;
  final String type;
  final double price;
  final String imageUrl; // Add image URL field

  Variant(this.size, this.type, this.price, this.imageUrl);
}

// Define the list of products
List<Product> products = [
  Product('DairyMilk', [
    Variant('10g', 'Regular', 10, 'https://images-cdn.ubuy.co.in/634d2a172304b002065a60e3-cadbury-dairy-milk-200-g.jpg'),
    Variant('35g', 'Regular', 30, 'https://images-cdn.ubuy.co.in/634d2a172304b002065a60e3-cadbury-dairy-milk-200-g.jpg'),
    Variant('110g', 'Regular', 80, 'https://images-cdn.ubuy.co.in/634d2a172304b002065a60e3-cadbury-dairy-milk-200-g.jpg'),
    Variant('110g', 'Silk', 95, 'https://images-cdn.ubuy.co.in/634d2a172304b002065a60e3-cadbury-dairy-milk-200-g.jpg'),
  ]),
  // Add other products similarly
];
