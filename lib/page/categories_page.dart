import 'dart:async';

import 'package:collaborate/bloc/auth_bloc.dart';
import 'package:collaborate/bloc/category_bloc.dart';
import 'package:collaborate/bloc/event_bloc.dart';
import 'package:collaborate/model/category.dart';
import 'package:collaborate/page/app_page.dart';
import 'package:collaborate/util/constants.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:collaborate/widget/category_item.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesPage extends StatefulWidget {
  static const String pageName = "/categories";

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
//  List<Category> _selectedCategories = [];
//  List<Category> _availableCategories = [];
//  StreamSubscription _subscription;
  bool _initDone = false;
  bool _isLoading = false;
//  bool _noUserCategories = true;
  List<Category> _categoriesWithSelection = [];

  AuthBloc authBloc;
  CategoriesBloc categoriesBloc;
  StreamSubscription _categoriesSubscription;

  @override
  void dispose() {
    // TODO: implement dispose
//    _subscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  bool get doesUserHasSelectedCategory {
    return _categoriesWithSelection.where((c) {
      return c.isSelected;
    }).isNotEmpty;
  }

  @override
  void didChangeDependencies() async {
    if (!_initDone) {
      setState(() {
        _isLoading = true;
      });
      authBloc = BlocProvider.of<AuthBloc>(context);
      categoriesBloc = BlocProvider.of<CategoriesBloc>(context);

      categoriesBloc
          .fetchCategoriesData(authBloc.token, authBloc.userId)
          .listen((_) {});

      _categoriesSubscription = CombineLatestStream.list<List<Category>>([
        categoriesBloc.outCategories,
        categoriesBloc.outUserCategories,
      ]).listen((categories) {
        List<Category> allCategories = categories[0];
        List<Category> userCategories = categories[1];

        _categoriesWithSelection =
            List<Category>.from(allCategories.map((category) {
          bool userSelectedCategory = false;
          if (userCategories.isNotEmpty) {
            userCategories.forEach((userCategory) {
              if (userCategory.id == category.id) {
                userSelectedCategory = true;
              }
            });
          }

          if (userSelectedCategory) {
            category.isSelected = true;
          }

          return category;
        }));

        setState(() {
          _categoriesWithSelection = _categoriesWithSelection;
        });
      });

      setState(() {
        _isLoading = false;
      });
    }
    _initDone = true;

    super.didChangeDependencies();
  }

//  _setInitialSelectedCategories(List<Category> allCategories) {
//    setState(() {
//      _availableCategories = allCategories;
//      _selectedCategories = allCategories.where((category) {
//        return category.isSelected == true;
//      }).toList();
//    });
//  }

  @override
  Widget build(BuildContext context) {
    final EventBloc eventBloc = BlocProvider.of<EventBloc>(context);

    _selectCategory(int categoryId) {
//      categoriesBloc.updateCategorySelection(categoryId);

      setState(() {
        final currentCategoryIndex =
            _categoriesWithSelection.indexWhere((category) {
          return category.id == categoryId;
        });

        final currentCategory = _categoriesWithSelection[currentCategoryIndex];
        currentCategory.isSelected = !currentCategory.isSelected;
        _categoriesWithSelection[currentCategoryIndex] = currentCategory;
      });
    }

    updateUserSelectedCategories() {
      categoriesBloc.updateCategorySelection(_categoriesWithSelection);
    }
//
//    List<Category> _getSelectedCategories(allCategories) {
//      return allCategories.where((category) {
//        return !!category.isSelected;
//      }).toList();
//    }

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Choose your interest')),
        ),
        body: _categoriesWithSelection.isEmpty
            ? kLoadingSpinner(color: Theme.of(context).primaryColor)
            : Column(
                children: <Widget>[
                  Expanded(
                    child: GridView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 15.0),
                      children: _categoriesWithSelection.map((category) {
                        return CategoryItem(
                          title: category.categoryName,
                          id: category.id,
                          selectCategory: _selectCategory,
                          isSelected: category.isSelected,
                        );
                      }).toList(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 20.0),
                    ),
                  ),
                  FlatButton(
                    child: Text('Choose Category'),
                    onPressed: () {
                      if (doesUserHasSelectedCategory) {
                        updateUserSelectedCategories();
                        Navigator.of(context).pushReplacementNamed(
                          AppPage.pageName,
                        );
                      }
                    },
                  ),
                  !doesUserHasSelectedCategory
                      ? Text(
                          'Please select atleast one category',
                          style: TextStyle(color: Colors.red),
                        )
                      : Container()
                ],
              ));
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    _categoriesSubscription.cancel();
    super.deactivate();
  }
}
