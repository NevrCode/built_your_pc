import 'package:built_your_pc/model/case_model.dart';
import 'package:built_your_pc/model/cpu_model.dart';
import 'package:built_your_pc/model/gpu_model.dart';
import 'package:built_your_pc/model/location_model.dart';
import 'package:built_your_pc/model/mobo_model.dart';
import 'package:built_your_pc/model/psu_model.dart';
import 'package:built_your_pc/model/ram_model.dart';
import 'package:built_your_pc/model/ssd_model.dart';

class PCModel {
  String id;
  String name;
  CPUModel cpu;
  GPUModel? gpu;
  SSDModel ssd;
  RAMModel ram;
  PSUModel psu;
  CaseModel pcCase;
  MoboModel mobo;
  String userId;
  String notes;
  LocationModel deliveryLocation;
  int get price => cpu.price + gpu!.price + ssd.price + ram.price + psu.price;

  PCModel({
    required this.id,
    required this.cpu,
    required this.name,
    this.gpu,
    required this.ssd,
    required this.ram,
    required this.psu,
    required this.pcCase,
    required this.mobo,
    required this.userId,
    required this.notes,
    required this.deliveryLocation,
  });

  factory PCModel.fromMap(Map<String, dynamic> map) {
    return PCModel(
      id: map['id'] as String,
      name: map['name'] as String,
      cpu: CPUModel.fromMap(map['cpu'] as Map<String, dynamic>),
      gpu: map['gpu'] != null
          ? GPUModel.fromMap(map['gpu'] as Map<String, dynamic>)
          : null,
      ram: RAMModel.fromMap(map['ram'] as Map<String, dynamic>),
      ssd: SSDModel.fromMap(map['ssd'] as Map<String, dynamic>),
      psu: PSUModel.fromMap(map['psu'] as Map<String, dynamic>),
      pcCase: CaseModel.fromMap(map['case'] as Map<String, dynamic>),
      mobo: MoboModel.fromMap(map['mobo'] as Map<String, dynamic>),
      userId: map['user_id'] as String,
      notes: map['notes'] as String,
      deliveryLocation: LocationModel.fromMap(
          map['delivery_location'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cpu': cpu.id,
      'gpu': gpu?.id,
      'ssd': ssd.id,
      'ram': ram.id,
      'psu': psu.id,
      'user_id': userId,
      'notes': notes,
      'delivery_location': deliveryLocation.id,
    };
  }

  Map<String, dynamic> toMapComplete() {
    return {
      'id': id,
      'cpu': cpu.toMap(),
      'gpu': gpu?.toMap(),
      'ssd': ssd.toMap(),
      'ram': ram.toMap(),
      'psu': psu.toMap(),
      'user_id': userId,
      'notes': notes,
      'delivery_location': deliveryLocation.toMap(),
    };
  }
}
