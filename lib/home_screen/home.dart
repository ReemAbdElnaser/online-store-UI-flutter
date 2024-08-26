import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/products_model.dart';
import '../shopinng/shopping_model.dart';
import 'package:provider/provider.dart';
import '../shopinng/shopingcar.dart';
import 'ProductDetailPage.dart';
import 'package:project_app/profile/ProfilePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Productsmodel? productsModel;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          productsModel = Productsmodel.fromJson(data);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load products';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred: $e';
        isLoading = false;
      });
    }
  }

  void _addToCart(Product product) {
    final cartModel = Provider.of<ShoppingCartModel>(context, listen: false);
    cartModel.addProduct(product);
  }

  void _openProductDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(product: product),
      ),
    );
  }

  void _openShoppingCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShoppingCartPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 166, 128, 232),
        title: Row(
          children: [
            
            Expanded(
              //child: Center(
                child: Text('Home Page'),
           //   ),
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: _openShoppingCart,
            ),
              IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : productsModel != null && productsModel!.products!.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.75,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      itemCount: productsModel!.products!.length,
                      itemBuilder: (context, index) {
                        final product = productsModel!.products![index];
                        final title = product.title ?? 'No Title';
                        final image = product.thumbnail ?? '';
                        final price = product.price?.toString() ?? '0';

                        return GestureDetector(
                          onTap: () => _openProductDetail(product),
                          child: Card(
                            elevation: 4.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        image,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 120,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Center(
                                              child: Icon(Icons.error));
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 8,
                                      right: 8,
                                      child: ElevatedButton(
                                        onPressed: () => _addToCart(product),
                                        child: Icon(Icons.add),
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(8),
                                          iconColor: Colors.deepPurple,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '\$$price',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(child: Text('No products available')),
    );
  }
}
