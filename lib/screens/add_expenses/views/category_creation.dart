import 'package:flutter/cupertino.dart';
import 'package:budget_app/screens/add_expenses/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:budget_app/data/icons.dart';
import 'package:budget_repository/budget_repository.dart';
import 'package:uuid/uuid.dart';

Future getCategoryCreation(BuildContext context) {
  return showDialog(
      context: context,
      builder: (ctx) {
        bool isExpanded = false;
        bool isLoading = false;
        String iconSelected = '';
        Color categoryColor = Colors.white;
        TextEditingController categoryNameController = TextEditingController();
        TextEditingController categoryIconController = TextEditingController();
        TextEditingController categoryColorController = TextEditingController();

        Category category = Category.empty;

        return BlocProvider.value(
          value: context.read<CreateCategoryBloc>(),
          child: StatefulBuilder(
            builder: (ctx, setState) {
              return BlocListener<CreateCategoryBloc, CreateCategoryState>(
                listener: (context, state) {
                  if (state is CreateCategorySuccess) {
                    Navigator.pop(ctx, category);
                  } else if (state is CreateCategoryLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                },
                child: AlertDialog(
                  title: const Text(
                    'Create a Category',
                    textAlign: TextAlign.center,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: categoryNameController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: categoryIconController,
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          suffixIcon:
                              const Icon(CupertinoIcons.chevron_down, size: 12),
                          fillColor: Colors.white,
                          hintText: 'Icon',
                          border: OutlineInputBorder(
                              borderRadius: isExpanded
                                  ? const BorderRadius.vertical(
                                      top: Radius.circular(15))
                                  : BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                        ),
                      ),
                      isExpanded
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(15))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  itemCount: myIcons.length,
                                  itemBuilder: (context, int i) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          iconSelected = myIcons[i]['name'];
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(8.0),
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color:
                                              iconSelected == myIcons[i]['name']
                                                  ? Colors.green
                                                  : Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child:
                                            Center(child: myIcons[i]['icon']),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: categoryColorController,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (ctx2) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ColorPicker(
                                        pickerColor: categoryColor,
                                        onColorChanged: (value) {
                                          setState(
                                            () {
                                              categoryColor = value;
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        height: kToolbarHeight,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(ctx2);
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                          ),
                                          child: const Text(
                                            "Select Color",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: categoryColor,
                          hintText: 'Color',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: kToolbarHeight,
                        child: isLoading == true
                            ? const Center(child: CircularProgressIndicator())
                            : TextButton(
                                onPressed: () {
                                  //Create Category Object then pop
                                  setState(() {
                                    category.categoryID = const Uuid().v1();
                                    category.name = categoryNameController.text;
                                    category.icon = iconSelected;
                                    category.color = categoryColor.value;
                                    context
                                        .read<CreateCategoryBloc>()
                                        .add(CreateCategory(category));
                                  });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      });
}
