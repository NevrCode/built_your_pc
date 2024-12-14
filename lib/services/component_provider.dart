import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/cpu_model.dart';
import 'package:flutter/material.dart';

class ComponentProvider with ChangeNotifier {
  List<CPUModel> cpu = [];
  List<String> types = ["cpu", "gpu", "ram", "ssd", "psu"];

  Future<void> addComponentModel(
    Map<String, dynamic> map,
    String type,
    String id,
  ) async {
    // components.add(model);
    await supabase.from(type).insert({
      'id': id,
      'name': map['name'],
      'price': map['price'],
      'description': map['desc'],
      'pic_url': map['pic_url'],
      'core_clock': map['clock'],
      'core_count': map['count'],
      'boost_clock': map['boost'],
      'tdp': map['tdp'],
      'graphics': map['graphics'],
      'stock': map['stock'],
    });
    notifyListeners();
  }

  // void fetchComponents() async {
  //   components.addAll((await supabase.from("cpu").select())
  //       .map((e) => CPU.fromMap(e))
  //       .toList());
  //   components.addAll((await supabase.from("gpu").select())
  //       .map((e) => GPU.fromMap(e))
  //       .toList());
  //   components.addAll((await supabase.from("ram").select())
  //       .map((e) => RAM.fromMap(e))
  //       .toList());
  //   components.addAll((await supabase.from("ssd").select())
  //       .map((e) => SSD.fromMap(e))
  //       .toList());
  //   components.addAll((await supabase.from("psu").select())
  //       .map((e) => PSU.fromMap(e))
  //       .toList());
  //   notifyListeners();
  // }

  // String _getTableName(ComponentModel model) {
  //   if (model is CPU) {
  //     return types[0];
  //   } else if (model is GPU) {
  //     return types[1];
  //   } else if (model is RAM) {
  //     return types[2];
  //   } else if (model is SSD) {
  //     return types[3];
  //   } else if (model is PSU) {
  //     return types[4];
  //   } else {
  //     throw Exception("Unsupported component");
  //   }
  // }
}
