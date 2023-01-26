import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../../models/product.dart';
import '../../../repository/productrepository.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  File? img;
  Future _loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint('Failed to pick Image $e');
    }
  }

  // adding product
  final String _selectedValue = "Please select a value";
  _addProduct(Product product) async {
    bool isAdded = await ProductRepository().addProduct(img, product);
    if (isAdded) {
      _displayMessage(isAdded);
    } else {
      _displayMessage(isAdded);
    }
  }

  _displayMessage(bool isAdded) {
    if (isAdded) {
      MotionToast.success(description: const Text("Product added successfully"))
          .show(context);
    } else {
      MotionToast.error(description: const Text("Error adding product"))
          .show(context);
    }
  }

  var gap = const SizedBox(height: 10);
  var brandnamecontroller = TextEditingController();
  var productNamecontroller = TextEditingController();
  var productDescriptioncontroller = TextEditingController();
  var productPricecontroller = TextEditingController();
  var rentPricecontroller = TextEditingController();
  var colorcontroller = TextEditingController();
  var sizecontroller = TextEditingController();
  var rentCategorycontroller = TextEditingController();

  _displayImage() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
      ),
      child: ClipRRect(
        // For rounded upper right corner and left corner in imageview
        borderRadius: BorderRadius.circular(20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: img == null
                      ? SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.network(
                            'http://www.clker.com/cliparts/o/G/p/l/g/M/add-student-hi.png',
                            fit: BoxFit.fill,
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: double.infinity,
                          ),
                        )
                      : Image.file(img!)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffE7EAEF),
        title: Text("Add Product", style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            _displayImage(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _loadImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera_enhance),
                    label: const Text('Open Camera'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _loadImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.browse_gallery_sharp),
                    label: const Text('Open Gallery'),
                  ),
                ),
              ],
            ),
            gap,
            //////brandname controller
            TextFormField(
              controller: brandnamecontroller,
              decoration: const InputDecoration(
                labelText: 'Brand Name',
                hintText: 'Enter brand Name',
                border: OutlineInputBorder(),
              ),
            ),
            //product name controller
            const SizedBox(height: 8),
            TextFormField(
              controller: productNamecontroller,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                hintText: 'Enter Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            gap,
            //product description controller
            const SizedBox(height: 8),
            TextFormField(
              controller: productDescriptioncontroller,
              decoration: const InputDecoration(
                labelText: 'Product Description',
                hintText: 'Enter Product Description',
                border: OutlineInputBorder(),
              ),
            ),
            gap,
            //size
            const SizedBox(height: 8),
            TextFormField(
              controller: productPricecontroller,
              decoration: const InputDecoration(
                labelText: 'Product Price',
                hintText: 'Enter Product Price',
                border: OutlineInputBorder(),
              ),
            ),
            gap,

            TextFormField(
              controller: rentPricecontroller,
              decoration: const InputDecoration(
                labelText: 'Rent Price',
                hintText: 'Enter rent price',
                border: OutlineInputBorder(),
              ),
            ),

            gap,
            TextFormField(
              controller: sizecontroller,
              decoration: const InputDecoration(
                labelText: 'Size ',
                hintText: 'Enter your size',
                border: OutlineInputBorder(),
              ),
            ),
            gap,
            const SizedBox(height: 8),
            TextFormField(
              controller: colorcontroller,
              decoration: const InputDecoration(
                labelText: 'Color ',
                hintText: 'Preferred color',
                border: OutlineInputBorder(),
              ),
            ),
            gap,
            const SizedBox(height: 8),
            TextFormField(
              controller: rentCategorycontroller,
              decoration: const InputDecoration(
                labelText: 'Rent Category',
                hintText: 'Enter rent category',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Product product = Product(
                      brandName: brandnamecontroller.text,
                      productName: productNamecontroller.text,
                      productPrice: num.parse(productPricecontroller.text),
                      rentPrice: num.parse(rentPricecontroller.text),
                      productDescription: productDescriptioncontroller.text,
                      rentCategory: rentCategorycontroller.text,
                      color: colorcontroller.text,
                      size: sizecontroller.text);
                  _addProduct(product);
                },
                label: const Text('Add Product'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
