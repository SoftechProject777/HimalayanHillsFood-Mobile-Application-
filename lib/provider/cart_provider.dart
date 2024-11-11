import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  int _quantity = 1;
  double _price = 168;

  int get quantity => _quantity;
  double get price => _price;
  void increaseQuantity() {
    _quantity++;
    _price = (_price * double.parse(_quantity.toString()));
    print(price);
    notifyListeners();
  }

  void decreaseQuantity() {
    if (_quantity > 1) {
      _quantity--;
      _price = (_price * double.parse(_quantity.toString()));
      print(price);
      notifyListeners();
    } else {}
  }
}


// In this provider we are writing the logic to calculate the quantity and price using increment and decrement icons.