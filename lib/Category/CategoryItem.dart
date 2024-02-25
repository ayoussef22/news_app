import 'package:flutter/material.dart';
import 'package:news_app/Model/MyCategory.dart';

class CategoryItem extends StatelessWidget {
  MyCategory category;
  int index;

  CategoryItem({required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(index % 2 == 0 ? 20 : 0),
            bottomRight: Radius.circular(index % 2 != 0 ? 20 : 0),
          )),
      child: Column(
        children: [
          Image.asset(
            category.imagePath,
            height: size.height * 0.19,
          ),
          Text(
            category.title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
