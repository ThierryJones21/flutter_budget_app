import 'package:budget_repository/budget_repository.dart';

abstract class BudgetRepository {
  Future<void> createCategory(Category category);
  Future<List<Category>> getCategory();
}
