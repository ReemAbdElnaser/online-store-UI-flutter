// category_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'productsScreen.dart'; // استيراد شاشة المنتجات

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/products/category-list'));
      if (response.statusCode == 200) {
        setState(() {
          _categories = List<String>.from(json.decode(response.body));
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // عرض رسالة خطأ إذا لزم الأمر
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error loading categories')));
    }
  }

  void _onCategorySelected(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductsScreen(category: category), // تمرير الفئة المحددة
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 166, 128, 232),
        title: Text('Categories'),
      ),
      body:
       _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return ListTile(
                  title: Text(category),
                  onTap: () => _onCategorySelected(category),
                );
              },
            ),
    );
  }
}
