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
      data: {'displayName': name, 'profile_picture': profilePic},
    );
    session = res.session;
    user = res.user;
    notifyListeners();
    return user;
  }

  Future<void> signOut() async {
    await supabase.auth.signOut(scope: SignOutScope.local);
    await PrefService().clearSession();
  }
}
