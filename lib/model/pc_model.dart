import 'package:built_your_pc/model/cpu_model.dart';
import 'package:built_your_pc/model/gpu_model.dart';
import 'package:built_your_pc/model/location_model.dart';
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
  String userId;
  String notes;
  LocationModel deliveryLocation;

  PCModel({
    required this.id,
    required this.cpu,
    required this.name,
    this.gpu,
    required this.ssd,
    required this.ram,
    required this.psu,
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
      ram: RAMModel.fromMap(map['cpu'] as Map<String, dynamic>),
      ssd: SSDModel.fromMap(map['ssd'] as Map<String, dynamic>),
      psu: PSUModel.fromMap(map['psu'] as Map<String, dynamic>),
      userId: map['userId'] as String,
      notes: map['notes'] as String,
      deliveryLocation: LocationModel.fromMap(
          map['deliveryLocation'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cpu': cpu.toMap(),
      'gpu': gpu?.toMap(),
      'ssd': ssd.toMap(),
      'ram': ram.toMap(),
      'psu': psu.toMap(),
      'userId': userId,
      'notes': notes,
      'deliveryLocation': deliveryLocation.toMap(),
    };
  }
}
