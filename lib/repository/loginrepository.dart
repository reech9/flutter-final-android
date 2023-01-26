import 'package:clothingrental/models/user.dart';

import '../api/userapi.dart';

class UserRepository {
  Future<bool> registerUser(User user) async {
    return await UserAPI().registerUser(user);
  }

  Future<bool> login(String username, String password) async {
    return UserAPI().login(username, password);
  }
}
