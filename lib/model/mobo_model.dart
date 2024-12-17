import 'package:built_your_pc/model/component_model.dart';

class MoboModel extends ComponentModel {
  String maxMemory;
  String memory;
  String formFactor;
  String socket;
  String color;

  MoboModel({
    required super.id,
    required super.name,
    required super.description,
    required super.picUrl,
    required super.price,
    required super.stock,
    required this.maxMemory,
    required this.socket,
    required this.formFactor,
    required this.color,
    required this.memory,
    super.tableType = "mobo",
  });

  factory MoboModel.fromMap(Map<String, dynamic> map) {
    return MoboModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      picUrl: map['pic_url'] as String,
      price: map['price'] as int,
      maxMemory: map['max_memory'] as String,
      color: map['color'] as String,
      socket: map['socket'] as String,
      formFactor: map['form_factor'] as String,
      memory: map['memory'] as String,
      stock: map['stock'] as int,
    );
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pic_url': picUrl,
      'price': price,
      'max_memory': maxMemory,
      'color': color,
      'form_factor': formFactor,
      'memory': memory,
      'socket': socket,
      'stock': stock,
    };
  }
}
