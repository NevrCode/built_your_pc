import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/user_model.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> users = [];
  Future<void> fetchUsers() async {
    final res = await supabase.from("user").select();
    users = res.map((e) => UserModel.fromMap(e)).toList();
    notifyListeners();
  }
}
