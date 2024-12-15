abstract class ComponentModel {
  final String id;
  final String name;
  final String description;
  final String picUrl;
  final int stock;
  final String type; // NOTE : buat supabase

  ComponentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.picUrl,
    required this.stock,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pic_url': picUrl
    };
  }
}
