import 'package:built_your_pc/model/user_model.dart';
import 'package:built_your_pc/services/user_provider.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersTablePage extends StatefulWidget {
  const UsersTablePage({super.key});

  @override
  State<UsersTablePage> createState() => _UsersTablePageState();
}

class _UsersTablePageState extends State<UsersTablePage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 1000,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: userProvider.users.length,
            itemBuilder: (context, index) {
              UserModel user = userProvider.users[index];
              String role = "";
              if (user.role == "admin") {
                role = "Administrator";
              } else {
                role = "User";
              }
              return ListTile(
                title: Text("$role (${user.name})"),
                subtitle: Text(user.email),
                leading: Image.network(
                  'https://rjkgsarcxukfiomccvrq.supabase.co/storage/v1/object/public/profile/${user.profilePicUrl}',
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) => SizedBox(
                    height: 50,
                    width: 50,
                    child: Icon(Icons.person, size: 50),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
