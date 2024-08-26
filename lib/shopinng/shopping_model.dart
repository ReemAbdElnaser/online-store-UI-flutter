// shopping_cart_model.dart
import 'package:flutter/material.dart';
import 'package:project_app/model/products_model.dart';
//import 'package:home.dart';

class ShoppingCartModel with ChangeNotifier {
  Map<Product, int> _productQuantities = {};

  Map<Product, int> get productQuantities => _productQuantities;

  void addProduct(Product product) {
    if (_productQuantities.containsKey(product)) {
      _productQuantities[product] = (_productQuantities[product] ?? 0) + 1;
    } else {
      _productQuantities[product] = 1;
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    if (_productQuantities.containsKey(product)) {
      _productQuantities.remove(product);
      notifyListeners();
    }
  }

  void increaseQuantity(Product product) {
    if (_productQuantities.containsKey(product)) {
      _productQuantities[product] = (_productQuantities[product]! + 1);
      notifyListeners();
    }
  }

  void decreaseQuantity(Product product) {
    if (_productQuantities.containsKey(product)) {
      if (_productQuantities[product]! > 1) {
        _productQuantities[product] = (_productQuantities[product]! - 1);
      } else {
        _productQuantities.remove(product);
      }
      notifyListeners();
    }
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var product in _productQuantities.keys) {
      total += (product.price ?? 0) * (_productQuantities[product] ?? 0);
    }
    return total;
  }
}
