import 'package:built_your_pc/model/pc_model.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.pc});
  final PCModel pc;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CostumText(
          data: "Payment",
          size: 14,
        ),
      ),
      body: Column(),
    );
  }
}
