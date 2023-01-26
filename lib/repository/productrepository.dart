import 'dart:io';

// import '../model/dropdown_category.dart';
import '../api/productapi.dart';
import '../models/product.dart';
import '../response/productresponse.dart';

class ProductRepository {
  Future<bool> addProduct(File? file, Product product) async {
    return ProductAPI().addProduct(file, product);
  }

  Future<bool> editProduct(Product product) async {
    return ProductAPI().editProduct( product);
  }

  Future<bool> deleteProduct(Product product) async {
    return ProductAPI().deleteProduct( product);
  }


  Future<List<Product>?> getProducts() async {
    return ProductAPI().getProducts();
  }


  Future<List<Product>?> getProductFromCategory(String categoryId) async {
    return ProductAPI().getProductFromCategory(categoryId);
  }


  Future<List<Product>?> getUserProduct() async {
    return ProductAPI().getUserProduct();
  }


  Future<Product?> getOneProduct(String id) async {
    return ProductAPI().getOneProduct(id);
  }
}
