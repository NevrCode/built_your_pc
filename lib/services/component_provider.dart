import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/component_model.dart';
import 'package:built_your_pc/model/cpu_model.dart';
import 'package:built_your_pc/model/gpu_model.dart';
import 'package:built_your_pc/model/psu_model.dart';
import 'package:built_your_pc/model/ram_model.dart';
import 'package:built_your_pc/model/ssd_model.dart';
import 'package:flutter/material.dart';

class ComponentProvider with ChangeNotifier {
  List<ComponentModel> components = [];
  List<ComponentModel> filtered = [];

  Future<void> addComponentModel(ComponentModel model) async {
    components.add(model);
    await supabase.from(model.tableType).insert(model.toMap());
    notifyListeners();
  }

  void filterItems(String query) {
    if (query.isEmpty) {
      filtered = components;
    } else {
      filtered = components
          .where((item) => item.name
              .toLowerCase()
              .contains(query.toLowerCase())) // Case-insensitive search
          .toList();
    }
    notifyListeners(); // Notify listeners about the change
  }

  Future<void> fetchComponents() async {
    List<ComponentModel> tempList = [];
    tempList.addAll((await supabase.from("cpu").select())
        .map((e) => CPUModel.fromMap(e))
        .toList());
    tempList.addAll((await supabase.from("gpu").select())
        .map((e) => GPUModel.fromMap(e))
        .toList());
    tempList.addAll((await supabase.from("ram").select())
        .map((e) => RAMModel.fromMap(e))
        .toList());
    tempList.addAll((await supabase.from("ssd").select())
        .map((e) => SSDModel.fromMap(e))
        .toList());
    tempList.addAll((await supabase.from("psu").select())
        .map((e) => PSUModel.fromMap(e))
        .toList());
    components = tempList;
    print(components);
    notifyListeners();
  }

  Future<void> updateComponent(ComponentModel model) async {
    int index = components.indexWhere((item) => item.id == model.id);
    print("ae");
    if (index != -1) {
      print("mauk");
      components[index] = model;
      await supabase
          .from(model.tableType)
          .update(model.toMap())
          .eq('id', model.id);
    }
    notifyListeners();
  }

  Future<void> deleteComponent(ComponentModel model) async {
    int index = components.indexWhere((item) => item.id == model.id);
    if (index != -1) {
      components.removeAt(index);
      await supabase.from(model.tableType).delete().eq('id', model.id);
    }
    notifyListeners();
  }
}
