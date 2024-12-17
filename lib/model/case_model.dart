import 'package:built_your_pc/model/component_model.dart';

class CaseModel extends ComponentModel {
  String color;
  String type;
  String sidePanel;
  String externalVolume;
  CaseModel({
    required super.id,
    required super.name,
    required super.description,
    required super.picUrl,
    required super.price,
    required super.stock,
    required this.sidePanel,
    required this.type,
    required this.externalVolume,
    required this.color,
    super.tableType = "case",
  });

  factory CaseModel.fromMap(Map<String, dynamic> map) {
    return CaseModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      picUrl: map['pic_url'] as String,
      price: map['price'] as int,
      sidePanel: map['side_panel'] as String,
      type: map['type'] as String,
      color: map['color'] as String,
      externalVolume: map['interface'] as String,
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
      'external_volume': externalVolume,
      'type': type,
      'color': color,
      'side_panel': sidePanel,
      'stock': stock,
    };
  }
}
