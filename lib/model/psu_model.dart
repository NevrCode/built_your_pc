import 'package:built_your_pc/model/component_model.dart';

class PSUModel extends ComponentModel {
  final String type;
  final String efficiency;
  final String wattage;
  final String modular;
  final String color;

  PSUModel({
    required super.id,
    required super.name,
    required super.picUrl,
    required super.description,
    required super.price,
    required this.type,
    required this.efficiency,
    required this.wattage,
    required this.modular,
    required this.color,
    required super.stock,
    super.tableType = "psu",
  });

  factory PSUModel.fromMap(Map<String, dynamic> map) {
    return PSUModel(
      id: map['id'] as String,
      name: map['name'] as String,
      picUrl: map['pic_url'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      type: map['type'] as String,
      efficiency: map['efficiency'] as String,
      wattage: map['wattage'] as String,
      modular: map['modular'] as String,
      color: map['color'] as String,
      stock: map['stock'] as int,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'pic_url': picUrl,
      'description': description,
      'price': price,
      'type': type,
      'efficiency': efficiency,
      'wattage': wattage,
      'modular': modular,
      'color': color,
      'stock': stock,
    };
  }
}
