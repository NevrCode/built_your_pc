import 'package:built_your_pc/model/component_model.dart';

class SSDModel extends ComponentModel {
  String capacity;
  String type;
  String formFactor;
  String interface;

  SSDModel({
    required super.id,
    required super.name,
    required super.description,
    required super.picUrl,
    required super.price,
    required super.stock,
    required this.capacity,
    required this.type,
    required this.formFactor,
    required this.interface,
    super.tableType = "ssd",
  });

  factory SSDModel.fromMap(Map<String, dynamic> map) {
    return SSDModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      picUrl: map['pic_url'] as String,
      price: map['price'] as int,
      capacity: map['capacity'] as String,
      type: map['type'] as String,
      formFactor: map['form_factor'] as String,
      interface: map['interface'] as String,
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
      'capacity': capacity,
      'type': type,
      'form_factor': formFactor,
      'interface': interface,
      'stock': stock,
    };
  }
}
