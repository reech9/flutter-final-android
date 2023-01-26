import 'dart:convert';

import 'package:clothingrental/Screens/widgets/SingleCard.dart';
import 'package:clothingrental/api/userapi.dart';
import 'package:clothingrental/repository/productrepository.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Product>? _products = [];

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async{
    var res =
    await ProductRepository().getProducts();
    setState(() {
      _products =res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffE7EAEF),
// creating icon as a title of an application

        title: Container(
          child: SizedBox(
            height: 42,
            width: 100,
            child: Wrap(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                ),
                Image.asset(
                  'assets/images/RENTME.png',
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,

// creating shopping category--action
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
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Image.asset("assets/images/logo.png"),
            Image.asset("assets/images/RENTME.png"),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text("My Products", style: TextStyle(fontSize: 24),),
                    trailing: Icon(Icons.sell_outlined, size: 24,),
                    onTap: (){

                      Navigator.of(context).pushNamed("my-product");
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text("Logout", style: TextStyle(fontSize: 24),),
                    trailing: Icon(Icons.logout, size: 24,),
                    onTap: (){
                      UserAPI().logout().then((value){
                        Navigator.of(context).pushReplacementNamed("login");
                      });
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: getProducts,
        child: ListView(children: [
          // tagline of an application
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.grey.shade500),
                child: Opacity(
                    opacity: 0.6,
                    child: Image.asset(
                      "assets/images/homebanner.png",
                      colorBlendMode: BlendMode.modulate,
                    )),
              ),
              Positioned.fill(
                top: 80,
                left: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/Luxury.png"),
                    Image.asset("assets/images/Fashion.png"),
                    Image.asset("assets/images/Accessories.png"),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),


          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              CategoryCard(context, "Party", "assets/images/party.jpg"),
              SizedBox(
                width: 20,
              ),
              CategoryCard(context, "Work", "assets/images/work.jpg"),
            ],
          ),
          SizedBox(
            height: 20,
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CategoryCard(context, "Vacation", "assets/images/vacation.jpg"),
              SizedBox(
                width: 20,
              ),
              CategoryCard(context, "Wedding", "assets/images/wedding.jpg"),
            ],
          ),
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
        ]),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget CategoryCard(BuildContext context, String? title, String? image) {
    return

      InkWell(
        onTap: () {
          Navigator.of(context).pushNamed("single-category",
              arguments:
                  json.encode({
                    "title": title.toString(),
                    "image": image.toString()
                  }));
        },

        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black.withOpacity(0.2))),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Image.asset(
                  image.toString(),
                  height: 100,
                  width: 160,
                  fit: BoxFit.cover,
                ),
                Container(
                    width: 160,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5)),
                    child: Text(
                      title.toString(),
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      );

  }

}
