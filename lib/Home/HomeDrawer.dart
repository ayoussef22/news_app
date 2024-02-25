import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  Function onDrawerItemClick;

  HomeDrawer({required this.onDrawerItemClick});

  static int categoryIndex = 1;
  static int settingsIndex = 2;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: size.height * 0.1),
          color: Theme.of(context).primaryColor,
          child: Text(
            'News App !',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () {
                  onDrawerItemClick(categoryIndex);
                },
                child: Row(
                  children: [
                    const Icon(Icons.list),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    Text(
                      'Category',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              InkWell(
                onTap: () {
                  onDrawerItemClick(settingsIndex);
                },
                child: Row(
                  children: [
                    const Icon(Icons.settings),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    Text(
                      'Settings',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
