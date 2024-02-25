import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Model/SourceResponse.dart';
import 'package:news_app/News/NewsContainer.dart';

import 'TabsItem.dart';

class SourcesTabs extends StatefulWidget {
  List<Source> sourcesList;

  SourcesTabs({required this.sourcesList});

  @override
  State<SourcesTabs> createState() => _SourcesTabsState();
}

class _SourcesTabsState extends State<SourcesTabs> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.sourcesList.length,
        child: Column(
          children: [
            TabBar(
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                isScrollable: true,
                indicatorColor: Colors.transparent,
                tabs: widget.sourcesList.map((source) {
                  return TabsItem(
                      sources: source,
                      isSelected:
                          selectedIndex == widget.sourcesList.indexOf(source));
                }).toList()),
            Expanded(
                child: NewsContainer(source: widget.sourcesList[selectedIndex]))
          ],
        ));
  }
}
