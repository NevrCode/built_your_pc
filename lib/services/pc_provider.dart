import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/pc_model.dart';
import 'package:flutter/material.dart';

class PCProvider with ChangeNotifier {
  List<PCModel> pcList = [];
  List<PCModel> filtered = [];

  Future<void> fetchPC() async {
    final res = await supabase.from("pc").select(
        "*, cpu(*), gpu(*), ram(*), ssd(*), psu(*), mobo(*), case(*), delivery_location(*)");
    pcList = res.map((e) => PCModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> addPC(PCModel pc) async {
    pcList.add(pc);
    await supabase.from("pc").insert(pc.toMap());
    notifyListeners();
  }

  void filterItems(String query) {
    if (query.isEmpty) {
      filtered = pcList;
    } else {
      filtered = pcList
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> deletePC(PCModel pc) async {
    int index = pcList.indexWhere((item) => item.id == pc.id);
    if (index != -1) {
      pcList.removeAt(index);
      await supabase.from("pc").delete().eq('id', pc.id);
    }
    notifyListeners();
  }
}
