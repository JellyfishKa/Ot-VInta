class ServiceModel {
  final int id;
  final String title;
  final String? description;
  final String? category; // Может быть ID или название категории
  final bool isActive;

  ServiceModel({
    required this.id,
    required this.title,
    this.description,
    this.category,
    required this.isActive,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'], 
      title: json['title'] ?? 'Без названия',
      description: json['description'],
      category: json['category']?.toString(),
      isActive: json['is_active'] ?? false,
    );
  }
}