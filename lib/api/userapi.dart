import 'dart:convert';

import 'package:clothingrental/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../response/loginresponse.dart';
import '../utils/url.dart';
import 'httpservices.dart';

class UserAPI {
  Future<bool> registerUser(User user) async {
    bool isLogin = false;
    // response comes from server
    Response response;
    var url = baseUrl + registerUrl;

    var dio = HttpServices().getInstance();
    try {
      response = await dio.post(
        url,
        data: user.toJson(),
      );
      if (response.statusCode == 200) {
        isLogin = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isLogin;
  }

  Future<bool> login(String username, String password) async {
    bool isLogin = false;
    try {
      var url = baseUrl + loginUrl;
      var dio = HttpServices().getInstance();

      var response = await dio.post(
        url,
        data: {
          "email": username,
          "password": password,
        },
      );
      print(response.data["message"]);
      if(response.data["message"].toString() == "Invalid credential********" || response.data["message"].toString() == "Invalid credentials*******"){
        throw Exception("Invalid Credentials");
      }
      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("LOGGED_IN_USER", json.encode(loginResponse));

        print(json.encode(loginResponse));
        token = loginResponse.token;
        userId = loginResponse.userId;
        isLogin = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isLogin;
  }
  Future<void> logout() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("LOGGED_IN_USER");
  }
}
