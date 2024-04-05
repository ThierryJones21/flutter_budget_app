import 'package:budget_app/data/icons_map.dart';
import 'package:budget_app/screens/add_expenses/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:budget_app/screens/add_expenses/views/category_creation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:budget_app/data/icons.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
          builder: (context, state) {
            if (state is GetCategoriesSuccess) {
              return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "New Expense",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: expenseController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              FontAwesomeIcons.dollarSign,
                              size: 20,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: categoryController,
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.list,
                            size: 20,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () async {
                                var newCategory =
                                    await getCategoryCreation(context);
                                setState(() {
                                  state.categories.insert(0, newCategory);
                                });
                              },
                              icon: const Icon(FontAwesomeIcons.plus,
                                  size: 16, color: Colors.grey)),
                          hintText: 'Category',
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15)),
                              borderSide: BorderSide.none),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(4),
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(15)),
                            color: Colors.white,
                          ),
                          child: ListView.builder(
                              itemCount: state.categories.length,
                              itemBuilder: (context, int i) {
                                final category = state.categories[i];
                                final iconName = category.icon;
                                final iconData = categoryIcons[iconName] ??
                                    FontAwesomeIcons.question; // Default icon
                                return Card(
                                    child: ListTile(
                                  leading:
                                      FaIcon(iconData, color: Colors.white),
                                  title: Text(category.name),
                                  tileColor: Color(category.color),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ));
                              })),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: dateController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: selectDate,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          );
                          if (newDate != null) {
                            setState(() {
                              dateController.text =
                                  DateFormat('dd/MM/yy').format(newDate);
                              selectDate = newDate;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.calendar,
                            size: 20,
                            color: Colors.grey,
                          ),
                          hintText: 'Calendar',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: kToolbarHeight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text(
                            "Add",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
