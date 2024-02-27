import 'package:flutter/material.dart';
import 'package:news_app/Category/CategoryDetails.dart';
import 'package:news_app/Category/CategoryFragment.dart';
import 'package:news_app/Home/HomeDrawer.dart';
import 'package:news_app/Home/NewsSearchDelegate.dart';
import 'package:news_app/Model/MyCategory.dart';
import 'package:news_app/Settings.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Container(
          color: Colors.white,
          child: Image.asset(
            'assets/background.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
            appBar: AppBar(
              title: Text(
                selectedDrawerItem == HomeDrawer.settingsIndex
                    ? 'Settings'
                    : selectedCategory == null
                        ? 'News App'
                        : selectedCategory!.title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              ),
              actions: [
                IconButton(onPressed: (){
                  showSearch(context: context, delegate: NewsSearchDelegate());
                }, icon: Icon(Icons.search_outlined,size: 30,))
              ],
            ),
            drawer: Drawer(
              child: HomeDrawer(
                onDrawerItemClick: onDrawerItemClick,
              ),
            ),
            body: selectedDrawerItem == HomeDrawer.settingsIndex
                ? const Settings()
                : selectedCategory == null
                    ? CategoryFragment(
                        onCategoryClick: onCategoryClick,
                      )
                    : CategoryDetails(category: selectedCategory!)),
      ]),
    );
  }

  MyCategory? selectedCategory;

  int? selectedDrawerItem;

  void onCategoryClick(MyCategory newSelectedCategory) {
    selectedCategory = newSelectedCategory;

    setState(() {});
  }

  void onDrawerItemClick(int newSelectedItem) {
    selectedDrawerItem = newSelectedItem;
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }
}
