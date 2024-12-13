abstract class ComponentModel {
  final String id;
  final String name;
  final String? description;
  final Map<String, dynamic>? detail;
  final int price;

  ComponentModel({
    required this.id,
    required this.name,
    this.description,
    this.detail,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'detail': detail,
      'price': price,
    };
  }
}

class CPU extends ComponentModel {
  CPU({
    required super.id,
    required super.name,
    super.description,
    super.detail,
    required super.price,
  });
  factory CPU.fromMap(Map<String, dynamic> map) {
    return CPU(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      detail: map['detail'] as Map<String, dynamic>?,
      price: map['price'] as int,
    );
  }
}

class GPU extends ComponentModel {
  GPU({
    required super.id,
    required super.name,
    super.description,
    super.detail,
    required super.price,
  });
  factory GPU.fromMap(Map<String, dynamic> map) {
    return GPU(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      detail: map['detail'] as Map<String, dynamic>?,
      price: map['price'] as int,
    );
  }
}

class RAM extends ComponentModel {
  RAM({
    required super.id,
    required super.name,
    super.description,
    super.detail,
    required super.price,
  });
  factory RAM.fromMap(Map<String, dynamic> map) {
    return RAM(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      detail: map['detail'] as Map<String, dynamic>?,
      price: map['price'] as int,
    );
  }
}

class SSD extends ComponentModel {
  SSD({
    required super.id,
    required super.name,
    super.description,
    super.detail,
    required super.price,
  });
  factory SSD.fromMap(Map<String, dynamic> map) {
    return SSD(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      detail: map['detail'] as Map<String, dynamic>?,
      price: map['price'] as int,
    );
  }
}

class PSU extends ComponentModel {
  PSU({
    required super.id,
    required super.name,
    super.description,
    super.detail,
    required super.price,
  });
  factory PSU.fromMap(Map<String, dynamic> map) {
    return PSU(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      detail: map['detail'] as Map<String, dynamic>?,
      price: map['price'] as int,
    );
  }
}
