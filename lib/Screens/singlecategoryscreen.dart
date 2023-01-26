import 'dart:convert';

import 'package:clothingrental/Screens/widgets/SingleCard.dart';
import 'package:clothingrental/api/cartapi.dart';
import 'package:clothingrental/api/productapi.dart';
import 'package:clothingrental/repository/cartrepository.dart';
import 'package:clothingrental/repository/productrepository.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class SingleCategoryScreen extends StatefulWidget {
  const SingleCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SingleCategoryScreen> createState() => _SingleCategoryScreenState();
}

class _SingleCategoryScreenState extends State<SingleCategoryScreen> {

  List<String> _data = List.generate(100, (index) => "Test");
  String? categoryId;
  String? image;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = json.decode(ModalRoute.of(context)!.settings.arguments.toString());

      print(args);
      setState(() {
        categoryId = args["title"];
        image = args["image"];
      });
      print(args);
      getProductWithCategory(args["title"]);
    });
    super.initState();
  }
  List<Product>? _products = [];
  Future<void> getProductWithCategory(String category) async {
    var res = await ProductRepository().getProductFromCategory(category);

    setState(() {
      _products = res;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffE7EAEF),
        title: Text(categoryId.toString(), style: TextStyle(
          color: Colors.black
        ),),
        actions: [
          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed("cart");
            },
            child: Container(
                padding: const EdgeInsets.only(right: 12),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body: ListView(
        children: [
          if(image!=null)Image.asset(image.toString(), height: 300, fit: BoxFit.cover,),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Products",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.8,
                  children: [
                    if(_products!=null)
                      ..._products!.map((e) => SingleCard(
                        id: e.id.toString(),
                        title: e.productName.toString(),
                        image: e.imageUrl.toString(),
                        price: e.productPrice.toString(),
                      )
                      )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
