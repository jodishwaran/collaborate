import 'package:collaborate/model/category.dart';
import 'package:collaborate/widget/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../api/http_helper.dart';

class CategoriesBloc extends BlocBase {
  static const String kGET_Category_URL =
      "https://ms-meetup-1.azurewebsites.net/categories";

  final BehaviorSubject<List<Category>> _subject =
      BehaviorSubject<List<Category>>();
  Sink<List<Category>> get _inCategories => _subject.sink;
  Stream<List<Category>> get outCategories => _subject.stream;

  CategoriesBloc() {
//    getAllCategories();
    List<Category> categories = [
      Category(id: 1.toString(), title: 'Dance', description: 'Dance desc'),
      Category(
          id: 2.toString(),
          title: 'Technology',
          description: 'Technology desc'),
      Category(id: 3.toString(), title: 'Sports', description: 'Sports desc'),
      Category(id: 4.toString(), title: 'Yoga', description: 'Yoga desc'),
    ];
    _inCategories.add(categories);
  }

  void getAllCategories() async {
    final responseBody = await HTTPHelper().get(kGET_Category_URL);

    final List<Category> categories =
        List<Category>.from(responseBody.map((categoryString) {
      return Category(
          id: DateTime.now().toString(),
          title: categoryString,
          description: '$categoryString description');
    }));

    _inCategories.add(categories);
  }

  updateCategorySelection(String categoryId) {
    List<Category> categories = _subject.value;
    final int categoryIndex = categories.indexWhere((c) {
      return c.id == categoryId;
    });

    Category category = categories[categoryIndex];

    category.isSelected = !category.isSelected;

    categories[categoryIndex] = category;

    _inCategories.add(categories);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _subject.close();
    super.dispose();
  }
}
