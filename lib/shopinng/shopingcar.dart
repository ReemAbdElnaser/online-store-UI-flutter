import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'shopping_model.dart'; // تأكد من استيراد ShoppingCartModel

class ShoppingCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<ShoppingCartModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 166, 128, 232),
        title: Text('Shopping Cart'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                '\$${cartModel.getTotalPrice().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: cartModel.productQuantities.isNotEmpty
          ? ListView.builder(
              itemCount: cartModel.productQuantities.length,
              itemBuilder: (context, index) {
                final product = cartModel.productQuantities.keys.elementAt(index);
                final quantity = cartModel.productQuantities[product] ?? 1;
                final title = product.title ?? 'No Title';
                final image = product.thumbnail ?? '';
                final price = product.price?.toString() ?? '0';

                return Card(
                  elevation: 4.0,
                  margin: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Image
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(child: Icon(Icons.error));
                          },
                        ),
                      ),
                      // Product Details and Quantity Controls
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                '\$$price',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                children: [
                                  // Decrease Quantity
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => cartModel.decreaseQuantity(product),
                                      child: Icon(Icons.remove),
                                      style: ElevatedButton.styleFrom(
                                        iconColor: Colors.deepPurple,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  // Quantity
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.deepPurple),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      '$quantity',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  // Increase Quantity
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => cartModel.increaseQuantity(product),
                                      child: Icon(Icons.add),
                                      style: ElevatedButton.styleFrom(
                                        iconColor: Colors.deepPurple,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(child: Text('Your cart is empty')),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Handle the order confirmation logic here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Order placed successfully!'),
              ),
            );
          },
          child: Text('Confirm Order'),
          style: ElevatedButton.styleFrom(
            iconColor: Colors.deepPurple,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
