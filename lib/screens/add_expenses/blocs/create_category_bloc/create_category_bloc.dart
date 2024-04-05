import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:budget_repository/budget_repository.dart';

part 'create_category_event.dart';
part 'create_category_state.dart';

class CreateCategoryBloc
    extends Bloc<CreateCategoryEvent, CreateCategoryState> {
  final BudgetRepository budgetRepository;

  CreateCategoryBloc(this.budgetRepository) : super(CreateCategoryInitial()) {
    on<CreateCategory>((event, emit) async {
      emit(CreateCategoryLoading());
      try {
        await budgetRepository.createCategory(event.category);
        emit(CreateCategorySuccess());
      } catch (e) {
        emit(CreateCategoryFailure());
      }
    });
  }
}
