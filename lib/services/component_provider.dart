import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/component_model.dart';
import 'package:flutter/material.dart';

class ComponentProvider with ChangeNotifier {
  List<ComponentModel> components = [];
  List<String> types = ["cpu", "gpu", "ram", "ssd", "psu"];

  void addComponentModel(ComponentModel model) async {
    components.add(model);
    await supabase.from(_getTableName(model)).insert(model.toMap());
    notifyListeners();
  }

  void fetchComponents() async {
    components.addAll((await supabase.from("cpu").select())
        .map((e) => CPU.fromMap(e))
        .toList());
    components.addAll((await supabase.from("gpu").select())
        .map((e) => GPU.fromMap(e))
        .toList());
    components.addAll((await supabase.from("ram").select())
        .map((e) => RAM.fromMap(e))
        .toList());
    components.addAll((await supabase.from("ssd").select())
        .map((e) => SSD.fromMap(e))
        .toList());
    components.addAll((await supabase.from("psu").select())
        .map((e) => PSU.fromMap(e))
        .toList());
    notifyListeners();
  }

  String _getTableName(ComponentModel model) {
    if (model is CPU) {
      return types[0];
    } else if (model is GPU) {
      return types[1];
    } else if (model is RAM) {
      return types[2];
    } else if (model is SSD) {
      return types[3];
    } else if (model is PSU) {
      return types[4];
    } else {
      throw Exception("Unsupported component");
    }
  }
}
