import 'package:built_your_pc/model/component_model.dart';

class CPUModel extends ComponentModel {
  final String tdp;
  final String graphics;
  final String clock;
  final String count;
  final String boost;

  CPUModel({
    required super.id,
    required this.tdp,
    required this.graphics,
    required this.clock,
    required this.count,
    required this.boost,
    required super.stock,
    required super.name,
    required super.description,
    required super.price,
    required super.picUrl,
    super.tableType = "cpu",
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pic_url': picUrl,
      'price': price,
      'stock': stock,
      'tdp': tdp,
      'graphics': graphics,
      'core_clock': clock,
      'core_count': count,
      'boost_clock': boost,
    };
  }

  factory CPUModel.fromMap(Map<String, dynamic> map) {
    return CPUModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      stock: map['stock'] as int,
      tdp: map['tdp'] as String,
      graphics: map['graphics'] as String,
      clock: map['core_clock'] as String,
      count: map['core_count'] as String,
      boost: map['boost_clock'] as String,
      picUrl: map['pic_url'] as String,
    );
  }
}
