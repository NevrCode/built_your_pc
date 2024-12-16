import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';

class UsersTablePage extends StatefulWidget {
  const UsersTablePage({super.key});

  @override
  State<UsersTablePage> createState() => _UsersTablePageState();
}

class _UsersTablePageState extends State<UsersTablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CostumText(data: "Users"),
      ),
      body: Column(),
    );
  }
}
