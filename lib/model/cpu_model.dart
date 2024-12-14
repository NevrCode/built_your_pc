class CPUModel {
  final String id;
  final String name;
  final String? description;
  final String tdp;
  final String graphics;
  final String clock;
  final int count;
  final String boost;
  final int price;
  final int stok;

  CPUModel({
    required this.id,
    required this.tdp,
    required this.graphics,
    required this.clock,
    required this.count,
    required this.boost,
    required this.stok,
    required this.name,
    this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
    };
  }

  factory CPUModel.fromMap(Map<String, dynamic> map) {
    return CPUModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      price: map['price'] as int,
      stok: map['stock'] as int,
      tdp: map['tdp'] as String,
      graphics: map['graphics'] as String,
      clock: map['core_clock'] as String,
      count: map['core_count'] as int,
      boost: map['boost_clock'] as String,
    );
  }
}
