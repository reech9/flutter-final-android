import 'dart:convert';

import 'package:clothingrental/Screens/widgets/SingleCard.dart';
import 'package:clothingrental/api/cartapi.dart';
import 'package:clothingrental/api/productapi.dart';
import 'package:clothingrental/repository/cartrepository.dart';
import 'package:clothingrental/repository/productrepository.dart';
import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    getMyCart();
    super.initState();
  }
  List<Cart>? _products = [];
  Future<void> getMyCart() async {
    var res = await CartRepository().getCartProducts();
    setState(() {
      _products = res;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Congratulation on your order.', textAlign: TextAlign.center,),
                  content:  Image.asset('assets/images/success.gif'),
                  actions: <Widget>[
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pop();
                    },child: Text("Close"),),
                  ],
                );
              });
          setState(() {
            _products = [];
          });
        },
        label: Text("Checkout"),
        icon: Icon(Icons.checkroom_outlined),
      ),
      appBar: AppBar(

        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffE7EAEF),
        title: Text("Cart", style: TextStyle(
            color: Colors.black
        ),),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your cart",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    if(_products!=null)
                      ..._products!.map((e) => SingleCardList(
                        id: e.productData.id.toString(),
                        title: e.productData.productName.toString(),
                        image: e.productData.imageUrl.toString(),
                        price: e.productData.productPrice.toString(),
                        quantity: e.quantity.toString(),
                        onPressed: ()=>removeFromCart(e.id),
                      )
                      )
                  ],
                ),
                SizedBox(height: 50,),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> removeFromCart(String id)  async{
    await CartRepository().removeFromCart(id);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cart Updated"), ),

    );
    getMyCart();
  }
}
