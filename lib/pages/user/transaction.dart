import 'package:built_your_pc/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Administrator"),
        SizedBox(
          height: 150,
          child: ListView(
            children: [
              ListTile(
                title: Text('Qmot (qmot@gmail.com)'),
                subtitle: Text('Status : Administrator'),
              ),
              ListTile(
                title: Text('Rio (rioferdian2004@gmail.com)'),
                subtitle: Text('Status : Administrator'),
                trailing: Text("Hello World"),
              ),
            ],
          ),
        ),
        Text("Users"),
        ElevatedButton(
            onPressed: () async {
              final prov = Provider.of<UserProvider>(context, listen: false);
              prov.fetchUsers();
            },
            child: Text("TOMBOL SAKTI"))
      ]),
    );
  }
}
