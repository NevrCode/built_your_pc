import 'package:built_your_pc/model/user_model.dart';
import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/services/user_provider.dart';
import 'package:built_your_pc/util/app_color.dart';
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
      backgroundColor: bg,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ContentContainer(
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          bottomLeft: Radius.circular(7)),
                      child: Image.network(
                        'https://rjkgsarcxukfiomccvrq.supabase.co/storage/v1/object/public/profile/${user.profilePicUrl}',
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => SizedBox(
                          height: 70,
                          width: 70,
                          child: Icon(Icons.person, size: 50),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CostumText(
                            data: "$role (${user.name})",
                            size: 14,
                          ),
                          CostumText(
                            data: user.email,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
