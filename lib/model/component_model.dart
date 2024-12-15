abstract class ComponentModel {
  final String id;
  final String name;
  final String description;
  final int price;
  final String picUrl;
  final int stock;
  final String tableType; // NOTE : buat supabase

  ComponentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.picUrl,
    required this.stock,
    required this.tableType,
  });

  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
