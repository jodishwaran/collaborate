import 'package:flutter/foundation.dart';

class Category {
  int id;
  String categoryName;
  bool isSelected;
  String imgPath;

  Category(
      {@required this.id,
      @required this.categoryName,
      this.isSelected = false,
      this.imgPath});
}
