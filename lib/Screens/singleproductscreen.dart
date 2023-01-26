import 'package:clothingrental/models/review.dart';
import 'package:clothingrental/repository/cartrepository.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../repository/productrepository.dart';
import '../repository/reviewrepository.dart';
import '../utils/url.dart';

class SingleProductScreen extends StatefulWidget {
  const SingleProductScreen({Key? key}) : super(key: key);

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  String? productId;
  String? image;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments.toString();

      print(args);
      setState(() {
        productId = args;
      });
      print(args);
      getProduct(args);
    });
    super.initState();
  }

  Product? _product;
  List<Review>? _review;
  Future<void> getProduct(String id) async {
    var res = await ProductRepository().getOneProduct(id);

    setState(() {
      _product = res;
    });
    var resReview = await ReviewRepository().getReviewForProduct(id);
    setState(() {
      _review = resReview;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _product == null
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return CartAction(
                        productId: _product!.id.toString(),
                      );
                    },
                  );
                },
                label: Text("Add to cart")),
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
                  onTap: () {
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
              onRefresh: ()=>getProduct(productId!),
              child: ListView(
                children: [
                  _product!.imageUrl == null || _product!.imageUrl == ""
                      ? Image.asset(
                          "assets/images/logo.png",
                          height: 300,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          _product!.imageUrl!.contains("http://localhost") ? baseUrl + _product!.imageUrl.toString().split("90/")[1] : _product!.imageUrl.toString(),
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _product!.productName,
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Rs. " + _product!.productPrice.toString(),
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.green),
                        ),
                        SizedBox(height: 20),
                        Wrap(
                          children: [
                            Icon(Icons.verified),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _product!.brandName.toString(),
                              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Wrap(
                          children: [
                            Icon(Icons.category),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _product!.rentCategory.toString(),
                              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          _product!.productDescription.toString(),
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Reviews",
                                    style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return ReviewWidget(productId: productId!, onSubmit: getProduct);
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.feedback))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if (_review != null)
                                ..._review!.map((e) => Card(
                                      elevation: 5,
                                      child: ListTile(
                                          title: Text(
                                            e.authorName.toString(),
                                            style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(e.reviewText),
                                              SizedBox(height: 5,),
                                              Text(e.reviewDate.toIso8601String()),
                                            ],
                                          )),
                                    ))
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

class ReviewWidget extends StatefulWidget {
  ReviewWidget({Key? key, required this.productId, required this.onSubmit}) : super(key: key);
  Future<void> Function(String) onSubmit;
  String productId;
  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  TextEditingController reviewController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Wrap(
        children: [
          Container(
            child: TextFormField(
              controller: reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
                hintText: 'Enter your review',
                hintStyle: const TextStyle(color: Colors.black),
              ),
            ),
            padding: EdgeInsets.all(10),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {

                    ReviewRepository().createReview(
                        Review(productId: widget.productId,
                            reviewText: reviewController.text,
                            reviewDate: DateTime.now())).then((value){
                              widget.onSubmit(widget.productId);
                              Navigator.of(context).pop();
                    });
                  },
                  child: Text("Review")))
        ],
      ),
    );
  }
}

class CartAction extends StatefulWidget {
  CartAction({Key? key, required this.productId}) : super(key: key);
  String productId = "";
  @override
  State<CartAction> createState() => _CartActionState();
}

class _CartActionState extends State<CartAction> {
  int quantity = 1;
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.shopping_cart),
            trailing: Wrap(
              children: [
                IconButton(
                    onPressed: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity -= 1;
                        });
                      }
                    },
                    icon: Icon(Icons.remove)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        quantity += 1;
                      });
                    },
                    icon: Icon(Icons.add)),
              ],
            ),
            title: Text('Quantity'),
            subtitle: Text(quantity.toString()),
          ),
          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('Delivery Date'),
            subtitle: Text(selectedDate.toIso8601String()),
            onTap: () {
              _selectDate(context);
            },
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    CartRepository().addToCart(widget.productId, quantity.toString(), selectedDate).then((value) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cart Updated")));
                    });
                  },
                  child: Text("Confirm")))
        ],
      ),
    );
  }
}
