class CategoryEntity {
  String categoryID;
  String name;
  int totalExpenses;
  String icon;
  int color;

  CategoryEntity({
    required this.categoryID,
    required this.name,
    required this.totalExpenses,
    required this.icon,
    required this.color,
  });

  Map<String, Object?> toDocument() {
    return {
      'categoryID': categoryID,
      'name': name,
      'totalExpenses': totalExpenses,
      'icon': icon,
      'color': color,
    };
  }

  static CategoryEntity fromDocument(Map<String, dynamic> doc) {
    return CategoryEntity(
        categoryID: doc['categoryID'],
        name: doc['name'],
        totalExpenses: doc['totalExpenses'],
        icon: doc['icon'],
        color: doc['color']);
  }
}
