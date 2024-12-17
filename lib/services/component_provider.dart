import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/case_model.dart';
import 'package:built_your_pc/model/component_model.dart';
import 'package:built_your_pc/model/cpu_model.dart';
import 'package:built_your_pc/model/gpu_model.dart';
import 'package:built_your_pc/model/mobo_model.dart';
import 'package:built_your_pc/model/psu_model.dart';
import 'package:built_your_pc/model/ram_model.dart';
import 'package:built_your_pc/model/ssd_model.dart';
import 'package:flutter/material.dart';

class ComponentProvider with ChangeNotifier {
  List<ComponentModel> components = [];
  List<ComponentModel> filtered = [];
  String? _selectedCategory;

  String _searchQuery = '';

  get selectedCategory => _selectedCategory;
  Future<void> addComponentModel(ComponentModel model) async {
    components.add(model);
    await supabase.from(model.tableType).insert(model.toMap());
    notifyListeners();
  }

  void filterItems(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  // Update category filter
  void filterByCategory(String? category) {
    _selectedCategory = category;
    _applyFilters();
  }

  // Apply both filters
  void _applyFilters() {
    filtered = components.where((item) {
      final matchesSearch = item.name.toLowerCase().contains(_searchQuery);
      final matchesCategory =
          _selectedCategory == null || item.tableType == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    notifyListeners();
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
    tempList.addAll((await supabase.from("case").select())
        .map((e) => CaseModel.fromMap(e))
        .toList());
    tempList.addAll((await supabase.from("mobo").select())
        .map((e) => MoboModel.fromMap(e))
        .toList());
    components = tempList;
    filtered = tempList;
    notifyListeners();
  }

  Future<void> updateComponent(ComponentModel model) async {
    int index = components.indexWhere((item) => item.id == model.id);
    if (index != -1) {
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

  // void filterByCategory(String? category) {
  //   _selectedCategory = category;
  //   _applyFilters();
  // }

  // // Apply both filters
  // void _applyFilters() {
  //   filtered = components.where((item) {
  //     final matchesSearch = item.name.toLowerCase().contains(_searchQuery);
  //     final matchesCategory =
  //         _selectedCategory == null || item.type == _selectedCategory;
  //     return matchesSearch && matchesCategory;
  //   }).toList();

  //   notifyListeners();
  // }
}
