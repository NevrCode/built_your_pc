import 'package:built_your_pc/model/component_model.dart';

class GPUModel extends ComponentModel {
  final String chipset;
  final String coreClock;
  final String boostClock;
  final String memory;
  final String color;
  final String length;

  GPUModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.picUrl,
    required this.chipset,
    required this.coreClock,
    required this.boostClock,
    required this.memory,
    required this.color,
    required this.length,
    required super.stock,
    super.tableType = "gpu",
  });

  factory GPUModel.fromMap(Map<String, dynamic> map) {
    return GPUModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      picUrl: map['pic_url'] as String,
      chipset: map['chipset'] as String,
      coreClock: map['core_clock'] as String,
      boostClock: map['boost_clock'] as String,
      memory: map['memory'] as String,
      color: map['color'] as String,
      length: map['length'] as String,
      stock: map['stock'] as int,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'pic_url': picUrl,
      'chipset': chipset,
      'core_clock': coreClock,
      'boost_clock': boostClock,
      'memory': memory,
      'color': color,
      'length': length,
      'stock': stock,
    };
  }
}
