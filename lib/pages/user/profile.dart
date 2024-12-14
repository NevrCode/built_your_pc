import 'package:built_your_pc/services/auth_provider.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return Container(
      child: MyButton(
          onTap: () {
            auth.signOut();
            if (mounted) {
              Navigator.pushReplacementNamed(context, "/login");
            }
          },
          child: CostumText(data: "logout")),
    );
  }
}
