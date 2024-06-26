import 'dart:math';
import 'package:budget_app/screens/add_expenses/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:budget_app/screens/add_expenses/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:budget_app/screens/add_expenses/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:budget_app/screens/add_expenses/views/add_expenses.dart';
import 'package:budget_app/screens/home/blocs/get_expenses/get_expenses_bloc.dart';
import 'package:budget_app/screens/home/views/main_screen.dart';
import 'package:budget_app/screens/stats/stats.dart';
import 'package:budget_repository/budget_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var wigdetList = [const StatsScreen()];

  int index = 0;
  late Color selectedItem = Colors.blue;
  Color unselectedItem = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpensesBloc, GetExpensesState>(
      builder: (context, state) {
        if (state is GetExpensesSuccess) {
          return Scaffold(
              bottomNavigationBar: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
                child: BottomNavigationBar(
                    onTap: (value) {
                      setState(() {
                        index = value;
                      });
                    },
                    backgroundColor: Colors.white,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    elevation: 3,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(
                            CupertinoIcons.home,
                            color: index == 0 ? selectedItem : unselectedItem,
                          ),
                          label: 'home'),
                      BottomNavigationBarItem(
                          icon: Icon(
                            CupertinoIcons.graph_square_fill,
                            color: index == 1 ? selectedItem : unselectedItem,
                          ),
                          label: 'stats'),
                    ]),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  var newExpense = await Navigator.push(
                      context,
                      MaterialPageRoute<Expense>(
                        builder: (BuildContext context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) =>
                                  CreateCategoryBloc(FirebaseExpenseRepo()),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  GetCategoriesBloc(FirebaseExpenseRepo())
                                    ..add(GetCategories()),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  CreateExpenseBloc(FirebaseExpenseRepo()),
                            ),
                          ],
                          child: const AddExpense(),
                        ),
                      ));
                  if (newExpense != null) {
                    setState(() {
                      state.expenses.add(newExpense);
                    });
                  }
                },
                shape: const CircleBorder(),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).colorScheme.tertiary,
                        ],
                        transform: const GradientRotation(pi / 4),
                      )),
                  child: const Icon(CupertinoIcons.add),
                ),
              ),
              body: index == 0 ? MainScreen(state.expenses) : StatsScreen());
        } else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
