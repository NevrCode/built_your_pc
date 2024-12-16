import 'package:built_your_pc/model/pc_model.dart';

class OrderModel {
  final String id;
  final PCModel pc;
  final String userId;
  String status;

  OrderModel({
    required this.id,
    required this.pc,
    required this.userId,
    required this.status,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
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
      'status': status,
    };
  }
}
