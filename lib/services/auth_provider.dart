import 'package:built_your_pc/services/pref.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class AuthProvider with ChangeNotifier {
  Session? session;
  User? user;
  Future<void> signInWithPass(String email, String pass) async {
    final res =
        await supabase.auth.signInWithPassword(email: email, password: pass);

    session = res.session;
    user = res.user;
    notifyListeners();
  }

  Future<User?> signUpWithPass(
      String email, String password, String name, String profilePic) async {
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'displayName': name,
        'profile_picture': profilePic,
        'roles': 'user'
      },
    );
    session = res.session;
    user = res.user;
    await supabase.from("user").insert({
      'id': res.user!.id,
      'email': res.user!.email,
      'role': 'user',
      'displayname': name,
      'profile_pic_url': profilePic
    });
    notifyListeners();
    return user;
  }

  Future<void> signOut() async {
    await supabase.auth.signOut(scope: SignOutScope.local);
    await PrefService().clearSession();
  }
}
