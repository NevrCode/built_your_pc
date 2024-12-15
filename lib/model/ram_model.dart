import 'package:built_your_pc/model/component_model.dart';

class RAMModel extends ComponentModel {
  final String capacity;
  final String speed;
  final String color;
  final String casLatency;
  final String firstWordLatency;

  RAMModel({
    required super.id,
    required super.name,
    required super.description,
    required super.picUrl,
    required super.price,
    required super.stock,
    required this.capacity,
    required this.speed,
    required this.color,
    required this.casLatency,
    required this.firstWordLatency,
    super.tableType = "ram",
  });

  factory RAMModel.fromMap(Map<String, dynamic> map) {
    return RAMModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      picUrl: map['pic_url'],
      price: map['price'],
      capacity: map['capacity'],
      speed: map['speed'],
      color: map['color'],
      casLatency: map['cas_latency'],
      firstWordLatency: map['first_word_latency'],
      stock: map['stock'],
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
      'speed': speed,
      'color': color,
      'cas_latency': casLatency,
      'first_word_latency': firstWordLatency,
      'stock': stock,
    };
  }
}
