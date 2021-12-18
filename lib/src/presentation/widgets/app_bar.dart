import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.deepPurple),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(64);
}
