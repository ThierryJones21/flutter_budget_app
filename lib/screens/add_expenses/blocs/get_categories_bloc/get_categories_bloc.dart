import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:budget_repository/budget_repository.dart';

part 'get_categories_event.dart';
part 'get_categories_state.dart';

class GetCategoriesBloc extends Bloc<GetCategoriesEvent, GetCategoriesState> {
  BudgetRepository budgetRepository;

  GetCategoriesBloc(this.budgetRepository) : super(GetCategoriesInitial()) {
    on<GetCategories>((event, emit) async {
      emit(GetCategoriesLoading());
      try {
        List<Category> categories = await budgetRepository.getCategory();
        emit(GetCategoriesSuccess(categories));
      } catch (e) {
        emit(GetCategoriesFailure());
      }
    });
  }
}
