import 'package:built_your_pc/model/location_model.dart';
import 'package:built_your_pc/model/pc_model.dart';

class OrderModel {
  final String id;
  final PCModel pc;
  final String userId;
  String status;
  final LocationModel loc;
  final String notes;
  final DateTime createdAt;

  OrderModel(
      {required this.loc,
      required this.notes,
      required this.id,
      required this.pc,
      required this.userId,
      required this.status,
      required this.createdAt});

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(

      id: map['id'] as String,
      loc: LocationModel.fromMap(map['locations'] as Map<String, dynamic>),
      notes: map["notes"] ?? '',
      pc: PCModel.fromMap(map['pc_id'] as Map<String, dynamic>),
      userId: map['user_id'] as String,
      status: map['status'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pc_id': pc.id,
      'user_id': userId,
      'notes': notes,
      'locations': loc.id,
      'status': status,
      'locations': loc,
      'notes': notes,
      'created_at': createdAt
    };
  }
}
