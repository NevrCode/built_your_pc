import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';

class AdminAddMenuPage extends StatefulWidget {
  const AdminAddMenuPage({super.key});

  @override
  State<AdminAddMenuPage> createState() => _AdminAddMenuPageState();
}

class _AdminAddMenuPageState extends State<AdminAddMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CostumText(data: "Pilih jenis produk", size: 14),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
