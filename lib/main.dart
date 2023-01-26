import 'package:clothingrental/Screens/cartscreen.dart';
import 'package:clothingrental/Screens/home/widgets/addproduct.dart';
import 'package:clothingrental/Screens/home/widgets/editproduct.dart';
import 'package:clothingrental/Screens/singlecategoryscreen.dart';
import 'package:clothingrental/Screens/singleproductscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screens/homescreen.dart';
import 'Screens/loginscreen.dart';
import 'Screens/myproductscreen.dart';
import 'Screens/registerscreen.dart';

void main(List<String> args) {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      theme: ThemeData().copyWith(
          textTheme: GoogleFonts.tenorSansTextTheme()
      ),
      routes: {
        'login': (context) => const LoginScreen(),
        'register': (context) => const RegisterScreen(),
        'home': (context) => const HomeScreen(),
        'single-product': (context) => const SingleProductScreen(),
        'single-category': (context) => const SingleCategoryScreen(),
        'add-product': (context) => const SingleCategoryScreen(),
        'cart': (context) => const CartScreen(),
        'my-product': (context) => const MyProductScreen(),
        'add-product': (context) => const AddProductScreen(),
        'edit-product': (context) => const EditProductScreen(),
      },
    );
  }
}
