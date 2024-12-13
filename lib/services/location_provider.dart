import 'package:flutter/material.dart';

import 'package:built_your_pc/main.dart';
import 'package:built_your_pc/model/location_model.dart';

class LocationProvider with ChangeNotifier {
  List<LocationModel> locations = [];
  Future<void> fetchData() async {
    final res = await supabase
        .from('locations')
        .select("*")
        .eq('user_id', supabase.auth.currentUser!.id);

    locations = res.map((e) => LocationModel.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> addData(Map<String, dynamic> data) async {
    locations.add(LocationModel.fromMap(data));
    await supabase.from('locations').insert({
      'location_id': data['location_id'],
      'location_name': data['location_name'],
      'street_name': data['street_name'],
      'rt_number': data['rt_number'],
      'rw_number': data['rw_number'],
      'street_number': data['street_number'],
      'kecamatan': data['kecamatan'],
      'kabupaten_or_kota': data['kabupaten_or_kota'],
      'user_id': data['user_id'],
    });
  }

  Future<void> updateData(LocationModel modifiedLocation) async {
    locations
        .removeWhere((item) => item.locationId == modifiedLocation.locationId);
    locations.add(modifiedLocation);
    await supabase
        .from('locations')
        .update(modifiedLocation.toMap())
        .eq('location_id', modifiedLocation.locationId);

    notifyListeners();
  }
}
