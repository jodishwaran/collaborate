import 'package:flutter/foundation.dart';

class Category {
  String id;
  String title;
  String description;
  bool isSelected;

  Category({
    @required this.id,
    @required this.title,
    @required this.description,
    this.isSelected = false,
  });
}
