import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/loginrepository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  _loginUser() async {
    bool isLogin = await UserRepository().login(_emailController.text, _passwordController.text);
    if (isLogin) {
      _showMessage(true);
    } else {
      _showMessage(false);
    }
  }

  _showMessage(bool isLogin) {
    if (isLogin) {
      Navigator.pushNamed(context, '/dashboard');
    } else {
      MotionToast.error(description: const Text('Invalid username or password')).show(context);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLogin(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
        tag: 'hero',
        child: Column(
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 100,
            ),
            Image.asset(
              "assets/images/RENTME.png",
            ),
            Image.asset(
              "assets/images/Women’s Luxury and beyond.png",
            ),
          ],
        ));

    final email = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
        hintText: 'Enter your email',
        hintStyle: const TextStyle(color: Colors.black),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter username';
        }
        return null;
      },
    );

    final password = TextFormField(
      controller: _passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
        hintText: 'Enter your password',
        hintStyle: const TextStyle(color: Colors.black),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ))),
        onPressed: () {
          login();
        },
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final registerButton = ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, 'register');
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ))),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Text('Create a new account', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xffE7EAEF),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              logo,
              const SizedBox(height: 38.0),
              email,
              const SizedBox(height: 20),
              password,
              const SizedBox(height: 20.0),
              InkWell(onTap: () {}, child: Text("Forgot your password?")),
              loginButton,
              registerButton
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkLogin(BuildContext context)  async{
    final prefs = await SharedPreferences.getInstance();
    bool checkLogin = prefs.containsKey("LOGGED_IN_USER");
    if(checkLogin){
      Navigator.of(context).pushReplacementNamed("home");
    }
  }

  Future<void> login()  async{
    try{
      var res = await UserRepository().login(_emailController.text, _passwordController.text);
      print(res);
      if (res) {
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        MotionToast.error(description: const Text("Login failed"))
            .show(context);
      }
    }catch(e){

      MotionToast.error(description:  Text(e.toString()))
          .show(context);
    }
  }
}
