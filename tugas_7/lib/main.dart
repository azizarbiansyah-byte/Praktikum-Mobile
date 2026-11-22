import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => CartModel(),
    child: const MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      scaffoldBackgroundColor: const Color(0xFFF5F6FA),
      useMaterial3: true,
    ),
    home: const ProductPage(),
  );
}

final products = [
  Product('Laptop', 'https://images.unsplash.com/photo-1496181133206-'
      '80ce9b88a853?w=600'),
  Product('Mouse', 'https://images.unsplash.com/photo-1527814050087-'
      '3793815479db?w=600'),
  Product('Keyboard', 'https://images.unsplash.com/photo-1587829741301-'
      'dc798b83add3?w=600'),
  Product('Headphone', 'https://images.unsplash.com/photo-1505740420928-'
      '5e560c06d30e?w=600'),
];

Widget productImage(String url, {double? width, double? height}) =>
    ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.image_not_supported),
      ),
    );

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Discover Store',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      actions: [
        Consumer<CartModel>(
          builder: (context, cart, _) => IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CartPage(),
              ),
            ),
            icon: Badge(
              label: Text('${cart.totalItems}'),
              isLabelVisible: cart.totalItems > 0,
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.62,
        ),
        itemBuilder: (context, index) {
          final p = products[index];

          return Card(
            color: Colors.white,
            elevation: 2,
            shadowColor: Colors.black12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: productImage(p.imageUrl)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          p.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          Provider.of<CartModel>(
                            context,
                            listen: false,
                          ).add(p);
                        },
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'My Cart',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    body: Consumer<CartModel>(
      builder: (context, cart, _) => cart.items.isEmpty
          ? const Center(
              child: Text('Keranjang masih kosong'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];

                return Card(
                  color: Colors.white,
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        productImage(
                          item.product.imageUrl,
                          width: 100,
                          height: 60,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            item.product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          '${item.quantity}x',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: () {
                            Provider.of<CartModel>(
                              context,
                              listen: false,
                            ).remove(item.product);
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          label: const Text(
                            'Hapus',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    ),
  );
}