import 'package:built_your_pc/model/component_model.dart';

class CaseModel extends ComponentModel {
  final String type;
  final String color;
  final String sidePanel;
  final String externalVolume;

  CaseModel({
    required super.id,
    required super.name,
    required super.price,
    required super.description,
    required super.picUrl,
    required super.stock,
    required this.type,
    required this.color,
    required this.sidePanel,
    required this.externalVolume,
    super.tableType = "case",
  });

  factory CaseModel.fromMap(Map<String, dynamic> map) {
    return CaseModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: map['price'] as int,
      type: map['type'] as String,
      color: map['color'] as String,
      sidePanel: map['side_panel'] as String,
      externalVolume: map['external_volume'] as String,
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
      'type': type,
      'description': description,
      'pic_url': picUrl,
      'color': color,
      'side_panel': sidePanel,
      'external_volume': externalVolume,
      'stock': stock,
    };
  }
}
