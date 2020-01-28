import 'package:collaborate/bloc/category_bloc.dart';
import 'package:collaborate/bloc/event_bloc.dart';
import 'package:collaborate/model/category.dart';
import 'package:collaborate/page/app_page.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:collaborate/widget/category_item.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  static const String pageName = "/categories";

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
//  List<Category> _selectedCategories = [];
//  List<Category> _availableCategories = [];
//  StreamSubscription _subscription;

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
    final CategoriesBloc categoriesBloc =
        BlocProvider.of<CategoriesBloc>(context);
    final EventBloc eventBloc = BlocProvider.of<EventBloc>(context);

    _selectCategory(String categoryId) {
      categoriesBloc.updateCategorySelection(categoryId);
    }

//    _subscription = provider.outCategories.listen((categories) {
//      _setInitialSelectedCategories(categories);
//    });

    List<Category> _getSelectedCategories(allCategories) {
      return allCategories.where((category) {
        return !!category.isSelected;
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Choose your interest')),
      ),
      body: StreamBuilder(
        stream: categoriesBloc.outCategories,
        builder: (BuildContext ctx, AsyncSnapshot<List<Category>> categories) {
          if (categories.hasData) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: GridView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    children: categories.data.map((category) {
                      return CategoryItem(
                        title: category.title,
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
                  onPressed: () async {
                    try {
                      await eventBloc.getFeaturedEvents(
                          _getSelectedCategories(categories.data));
                      Navigator.of(context).pushReplacementNamed(
                        AppPage.pageName,
                      );
                    } catch (e) {
                      print('Exception occured during fetch featured evnts');
                      throw (e);
                    }

//
                  },
                )
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
