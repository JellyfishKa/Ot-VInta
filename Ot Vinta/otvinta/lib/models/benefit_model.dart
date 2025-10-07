class BenefitModel {
  final int id;
  final String title;
  final String? description;
  final String? category;
  final bool isActive;

  BenefitModel({
    required this.id,
    required this.title,
    this.description,
    this.category,
    required this.isActive,
  });

  factory BenefitModel.fromJson(Map<String, dynamic> json) {
    return BenefitModel(
      id: json['id'],
      title: json['title'] ?? 'Без названия',
      description: json['description'],
      category: json['category']?.toString(),
      isActive: json['is_active'] ?? false,
    );
  }
}