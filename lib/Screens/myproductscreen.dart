import 'dart:convert';

import 'package:clothingrental/Screens/widgets/SingleCard.dart';
import 'package:clothingrental/api/cartapi.dart';
import 'package:clothingrental/api/productapi.dart';
import 'package:clothingrental/models/review.dart';
import 'package:clothingrental/repository/cartrepository.dart';
import 'package:clothingrental/repository/productrepository.dart';
import 'package:clothingrental/repository/reviewrepository.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

import '../models/product.dart';
import '../utils/url.dart';

class MyProductScreen extends StatefulWidget {
  const MyProductScreen({Key? key}) : super(key: key);

  @override
  State<MyProductScreen> createState() => _MyProductScreenState();
}

class _MyProductScreenState extends State<MyProductScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMyProduct();
    });
    super.initState();
  }

  List<Product>? _products = [];
  Future<void> getMyProduct() async {
    try{

      var res = await ProductRepository().getUserProduct();
      setState(() {
        _products = res;
      });

    }catch(e){}
  }
  Future<void> deleteProduct(Product e) async{
    try{
      await ProductRepository().deleteProduct(e);
      var res = await ProductRepository().getUserProduct();
      setState(() {
        _products = res;
      });
      MotionToast.success(description: Text("Delete Successful"));
    }catch(e){
      MotionToast.error(description: Text("Server error."));}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.of(context).pushNamed("add-product");
          }, label: Text("Add Product"),
        icon: Icon(Icons.sell),
      ),
      appBar: AppBar(
        
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffE7EAEF),
        title: Text("My Products", style: TextStyle(
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
      body: RefreshIndicator(
        onRefresh: getMyProduct,
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
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
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      if(_products!=null)
                        ..._products!.map((e) =>
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed("single-product", arguments: e.id);
                              },
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  trailing: Wrap(
                                    children: [
                                      IconButton(onPressed: (){
                                        Navigator.of(context).pushNamed("edit-product", arguments: e);
                                      }, icon: Icon(Icons.edit, color: Colors.orange,)),
                                      IconButton(onPressed: (){
                                        deleteProduct(e);
                                      }, icon: Icon(Icons.delete, color: Colors.red,)),
                                    ],
                                  ),
                                  leading:  e.imageUrl == null ||  e.imageUrl == ""
                                    ? Image.asset(
                                    "assets/images/logo.png",
                                    height: 130,
                                    fit: BoxFit.cover,
                                    )
                                        : Image.network(
                                    e.imageUrl!.contains("http://localhost")
                                    ? baseUrl +  e.imageUrl!.split("90/")[1]
                                        :  e.imageUrl.toString(),
                                    height: 130,
                                    fit: BoxFit.cover,
                                    ),
                                    title: Text(e.productName.toString(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),),
                                    subtitle: Text(
                                      "Rs ${e.productPrice}",
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: Color(0xffDD8560),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),

                                ),
                              ),
                            )
                        //     SingleCard(
                        //   id: e.id.toString(),
                        //   title: e.productName.toString(),
                        //   image: e.imageUrl.toString(),
                        //   price: e.productPrice.toString(),
                        // )
                        )
                    ],
                  ),
                  // GridView.count(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   crossAxisCount: 2,
                  //   crossAxisSpacing: 20,
                  //   mainAxisSpacing: 20,
                  //   childAspectRatio: 0.8,
                  //   children: [
                  //     if(_products!=null)
                  //       ..._products!.map((e) => SingleCard(
                  //         id: e.id.toString(),
                  //         title: e.productName.toString(),
                  //         image: e.imageUrl.toString(),
                  //         price: e.productPrice.toString(),
                  //       )
                  //       )
                  //   ],
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
