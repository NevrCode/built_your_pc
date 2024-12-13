class Order {
  final int id;
  final String? pcId;
  final String? userId;
  final String? status;

  Order({
    required this.id,
    this.pcId,
    this.userId,
    this.status,
  });

  // Factory constructor to create an Order from a map
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int,
      pcId: map['pc_id'] as String?,
      userId: map['user_id'] as String?,
      status: map['status'] as String?,
    );
  }

  // Method to convert an Order instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pc_id': pcId,
      'user_id': userId,
      'status': status,
    };
  }
}
