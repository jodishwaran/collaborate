import 'package:collaborate/model/category.dart';
import 'package:collaborate/util/endpoints.dart';
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

  final BehaviorSubject<List<Category>> _userCategoriesSubject =
      BehaviorSubject<List<Category>>();
  Sink<List<Category>> get _inUserCategories => _userCategoriesSubject.sink;
  Stream<List<Category>> get outUserCategories => _userCategoriesSubject.stream;

  CategoriesBloc() {
//    getAllCategories();
//    List<Category> categories = [
//      Category(
//        id: 1.toString(),
//        categoryName: 'Dance',
//      ),
//      Category(id: 2.toString(), categoryName: 'Technology'),
//      Category(id: 3.toString(), categoryName: 'Sports'),
//      Category(
//        id: 4.toString(),
//        categoryName: 'Yoga',
//      ),
//    ];
//    _inCategories.add(categories);
  }

  Future<bool> fetchCategories(token) async {
    final headers = {'Authorization': 'Bearer $token'};
    return await getAllCategories(headers);
  }

  Future<bool> getAllCategories(Map<String, String> headers) async {
    final responseBody = await HTTPHelper()
        .get(url: Endpoints.kgetAllCategories, headers: headers);

    print(responseBody.forEach((category) {
      print(category);
    }));

    final List<Category> categories = _mapResponseToCategories(responseBody);
    _inCategories.add(categories);
    return true;
  }

  _mapResponseToCategories(response) {
    return List<Category>.from(response.map((categoryObj) {
      return Category(
          id: categoryObj['id'],
          categoryName: categoryObj['categoryName'],
          imgPath: 'images/${categoryObj['categoryName']}.jpeg');
    }));
  }

  fetchUserCategories(int userId, String token) async {
    final headers = {'Authorization': 'Bearer $token'};
    final responseBody = await HTTPHelper()
        .get(url: Endpoints.kgetUserCategories(userId), headers: headers);

//    if (responseBody == null && responseBody['error']) {
//      return false;
//    }

    if ((responseBody as List<dynamic>).isNotEmpty) {
      print(responseBody.forEach((category) {
        print(category);
      }));
    } else {
      print('***********response is null*******************');
    }

    final List<Category> categories = _mapResponseToCategories(responseBody);

    _inUserCategories.add(categories);
    return true;
  }

  fetchCategoriesData(String token, int userId) {
    return ForkJoinStream.list([
      Stream.fromFuture(fetchCategories(token)),
      Stream.fromFuture(fetchUserCategories(userId, token)),
    ]);
  }

  updateCategorySelection(
      List<Category> categoriesWithSelection, userId, token) async {
    final userSelectedCategories = categoriesWithSelection.where((category) {
      return category.isSelected;
    }).toList();

    final userSelectedCategoriesData = userSelectedCategories.map((category) {
      return {
        "categoryId": category.id,
        "userId": userId,
      };
    }).toList();

    print(userSelectedCategoriesData);

    try {
      await postUserCategories(userId, token, userSelectedCategoriesData);
      _inUserCategories.add(userSelectedCategories);
    } catch (err) {
      print('Error while saving categories for user $userId');
    }
  }

  postUserCategories(
      int userId, String token, userSelectedCategoriesData) async {
    final url = Endpoints.kgetUserCategories(userId);
    await HTTPHelper()
        .post(data: userSelectedCategoriesData, token: token, url: url);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _subject.close();
    super.dispose();
  }
}
