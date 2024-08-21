import 'package:flutter/material.dart';
import 'package:news_app/Model/SourceResponse.dart';
import 'package:news_app/MyTheme.dart';

class TabsItem extends StatelessWidget {
  Source? sources;
  bool isSelected;

  TabsItem({required this.sources, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: size.height * 0.02),
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.007, horizontal: size.width * 0.04),
      decoration: BoxDecoration(
          color: isSelected ? MyTheme.primaryColor : Colors.transparent,
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          borderRadius: BorderRadius.circular(18)),
      child: Text(sources?.name ?? "",
          style: isSelected
              ? Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.white)
              : Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Theme.of(context).primaryColor)),
    );
  }
}
