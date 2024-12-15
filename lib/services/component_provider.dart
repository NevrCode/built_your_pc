import 'dart:developer';

import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/component_model.dart';
import 'package:built_your_pc/model/cpu_model.dart';
import 'package:flutter/material.dart';

class ComponentProvider with ChangeNotifier {
  List<ComponentModel> components = [];

  Future<void> addComponentModel(ComponentModel model) async {
    components.add(model);
    await supabase.from(model.type).insert(model.toMap());
    log(components.toString());
    log("finish");
    notifyListeners();
  }

  Future<void> fetchComponents() async {
    List<ComponentModel> tempList = [];
    tempList.addAll((await supabase.from("cpu").select())
        .map((e) => CPUModel.fromMap(e))
        .toList());
    // tempList.addAll((await supabase.from("gpu").select())
    //     .map((e) => GPU.fromMap(e))
    //     .toList());
    // tempList.addAll((await supabase.from("ram").select())
    //     .map((e) => RAM.fromMap(e))
    //     .toList());
    // tempList.addAll((await supabase.from("ssd").select())
    //     .map((e) => SSD.fromMap(e))
    //     .toList());
    // tempList.addAll((await supabase.from("psu").select())
    //     .map((e) => PSU.fromMap(e))
    //     .toList());
    components = tempList;
    log(components.toString());
    notifyListeners();
  }

  Future<void> updateComponent(ComponentModel model) async {
    int index = components.indexWhere((item) => item.id == model.id);
    if (index != -1) {
      components[index] = model;
      await supabase.from(model.type).update(model.toMap()).eq('id', model.id);
    }
    notifyListeners();
  }

  Future<void> deleteComponent(ComponentModel model) async {
    int index = components.indexWhere((item) => item.id == model.id);
    if (index != -1) {
      components.removeAt(index);
      await supabase.from(model.type).delete().eq('id', model.id);
    }
    notifyListeners();
  }
}
