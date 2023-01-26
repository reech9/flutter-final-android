import 'dart:io';

// import '../model/dropdown_category.dart';
import 'package:clothingrental/api/cartapi.dart';

import '../api/productapi.dart';
import '../models/cart.dart';
import '../models/product.dart';
import '../response/productresponse.dart';

class CartRepository {
  Future<bool> addToCart(String productId, String quantity, DateTime deliveryDate) async {
    return CartApi().addToCart(productId, quantity, deliveryDate);
  }

  Future<List<Cart>?> getCartProducts() async {
    return CartApi().getCartProducts();
  }


  Future<bool> removeFromCart(String cartId) async {
    return CartApi().removeFromCart(cartId);
  }

}
