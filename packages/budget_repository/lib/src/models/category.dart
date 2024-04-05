import 'package:budget_repository/src/entities/entities.dart';

class Category {
  String categoryID;
  String name;
  int totalExpenses;
  String icon;
  int color;

  Category({
    required this.categoryID,
    required this.name,
    required this.totalExpenses,
    required this.icon,
    required this.color,
  });

  static final empty = Category(
    categoryID: '',
    name: '',
    totalExpenses: 0,
    icon: '',
    color: 0,
  );

  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryID: categoryID,
      name: name,
      totalExpenses: totalExpenses,
      icon: icon,
      color: color,
    );
  }

  static Category fromEntity(CategoryEntity entity) {
    return Category(
        categoryID: entity.categoryID,
        name: entity.name,
        totalExpenses: entity.totalExpenses,
        icon: entity.icon,
        color: entity.color);
  }
}
