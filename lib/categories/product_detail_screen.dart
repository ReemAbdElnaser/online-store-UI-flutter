// product_detail_screen.dart
import 'package:flutter/material.dart';


class ProductDetailScreen extends StatelessWidget {
  final dynamic product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    final title = product['title'] ?? 'No Title';
    final image = product['thumbnail'] ?? 'https://via.placeholder.com/150';
    final price = product['price']?.toString() ?? '0';
    final description = product['description'] ?? 'No Description';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 166, 128, 232),
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.error));
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '\$$price',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  
                },
                  
                
                child: Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  iconColor: Color.fromARGB(255, 166, 128, 232),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
