import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final int id;
  final Function selectCategory;
  final bool isSelected;
  final String imgPath;
  CategoryItem(
      {this.title,
      this.id,
      this.selectCategory,
      this.isSelected,
      this.imgPath});

  @override
  Widget build(BuildContext context) {
    print('printing imagePath___******');
    print(imgPath);
    return InkWell(
      onTap: () {
//        Navigator.of(context)
//            .pushReplacementNamed(AppPage.pageName, arguments: title);

        selectCategory(id);
      },
      child: Stack(children: <Widget>[
        Image.asset(imgPath),
        Container(
          color:
              isSelected ? Color(0xFF222E3E) : Theme.of(context).primaryColor,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            child: GridTile(
              child: Center(
                child: Text(
                  '$title',
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.body2.fontSize,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
