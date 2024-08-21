import 'package:flutter/material.dart';
import 'package:news_app/Category/CategoryItem.dart';
import 'package:news_app/Model/MyCategory.dart';

class CategoryFragment extends StatelessWidget {
  List<MyCategory> categoryList = MyCategory.getCategories();
  Function onCategoryClick;

  CategoryFragment({required this.onCategoryClick});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.08, vertical: size.height * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pick your category \nof interest',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: size.width * 0.05,
                  mainAxisSpacing: size.height * 0.03),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      onCategoryClick(categoryList[index]);
                    },
                    child: CategoryItem(
                        category: categoryList[index], index: index));
              },
              itemCount: categoryList.length,
            ),
          )
        ],
      ),
    );
  }
}
