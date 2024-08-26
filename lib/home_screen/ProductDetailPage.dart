import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // تأكد من استيراد مكتبة JSON
import '../model/products_model.dart';
import '../shopinng/shopping_model.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<ShoppingCartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? 'Product Details'),
        backgroundColor: const Color.fromARGB(255, 166, 128, 232),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product.thumbnail ?? '', // استخدام 'thumbnail' بدلاً من 'image'
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
            errorBuilder: (context, error, stackTrace) {
              return Center(child: Icon(Icons.error));
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              product.title ?? 'No Title',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '\$${product.price ?? 0}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () => cartModel.addProduct(product),
              child: Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                iconColor: Colors.deepPurple,
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: fetchSimilarProducts(product), // Implement this function
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  final similarProducts = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.75,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: similarProducts.length,
                    itemBuilder: (context, index) {
                      final similarProduct = similarProducts[index];
                      return Card(
                        elevation: 4.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  similarProduct.thumbnail ?? '', // استخدام 'thumbnail' بدلاً من 'image'
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(child: Icon(Icons.error));
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                similarProduct.title ?? 'No Title',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '\$${similarProduct.price ?? 0}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No similar products found.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Product>> fetchSimilarProducts(Product product) async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final products = Productsmodel.fromJson(data).products!;
      return products.where((p) => p.category == product.category).toList();
    } else {
      throw Exception('Failed to load similar products');
    }
  }
}
