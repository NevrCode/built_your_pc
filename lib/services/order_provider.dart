import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> orders = [];

  Future<void> fetchOrders() async {
    final res = await supabase.from("orders").select(
        "*, pc_id(*, cpu(*), gpu(*), ram(*), ssd(*), psu(*), mobo(*), case(*)), locations(*)");
    orders = res.map((e) => OrderModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> addOrder(OrderModel order) async {
    orders.add(order);
    await supabase.from("orders").insert(order.toMap());
    notifyListeners();
  }

  Future<void> modifyStatus(OrderModel order) async {
    int index = orders.indexWhere((model) => model.id == order.id);
    if (index != -1) {
      orders[index].status = "Selesai";

      await supabase.from("orders").update(order.toMap()).eq("id", order.id);
    }
    notifyListeners();
  }
}
