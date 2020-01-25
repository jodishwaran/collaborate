import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String id;
  final Function selectCategory;
  final bool isSelected;
  CategoryItem({
    this.title,
    this.id,
    this.selectCategory,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
//        Navigator.of(context)
//            .pushReplacementNamed(AppPage.pageName, arguments: title);

        selectCategory(id);
      },
      child: Container(
        color: isSelected ? Colors.teal : Colors.greenAccent,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          child: GridTile(
            child: Center(
              child: Text(
                '$title',
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.body2.fontFamily,
                  fontSize: Theme.of(context).textTheme.body2.fontSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
