import 'package:flutter/material.dart';

appBar(String title, String rightTitle, VoidCallback rightButtonClicked) {
  return AppBar(
    centerTitle: false,
    titleSpacing: 0,
    leading: const BackButton(),
    title: Text(
      title,
      style: const TextStyle(fontSize: 18),
    ),
    actions: [
      InkWell(
        onTap: rightButtonClicked,
        child: Container(
          padding: const EdgeInsets.only(left: 175, right: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[500],
            ),
          ),
        ),
      ),
    ],
  );
}
