import 'package:built_your_pc/model/component_model.dart';

class MoboModel extends ComponentModel {
  final String socket;
  final String formFactor;
  final String maxMemory;
  final int memorySlots;
  final String color;

  MoboModel({
    required super.id,
    required super.name,
    required super.price,
    required super.description,
    required super.picUrl,
    required super.stock,
    required this.socket,
    required this.formFactor,
    required this.maxMemory,
    required this.memorySlots,
    required this.color,
    super.tableType = "mobo",
  });

  factory MoboModel.fromMap(Map<String, dynamic> map) {
    return MoboModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: map['price'] as int,
      socket: map['socket'] as String,
      formFactor: map['form_factor'] as String,
      maxMemory: map['max_memory'] as String,
      memorySlots: map['memory_slots'] as int,
      color: map['color'] as String,
      description: map['description'] as String,
      picUrl: map['pic_url'] as String,
      stock: map['stock'] as int,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'pic_url': picUrl,
      'socket': socket,
      'form_factor': formFactor,
      'max_memory': maxMemory,
      'memory_slots': memorySlots,
      'color': color,
      'stock': stock,
    };
  }
}
