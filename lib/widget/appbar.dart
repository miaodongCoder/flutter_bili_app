import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/view_util.dart';

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

videoAppBar() {
  return Container(
    padding: const EdgeInsets.only(left: 8),
    decoration: BoxDecoration(
      gradient: blackLinearGradient(fromTop: true),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BackButton(
          color: Colors.white,
        ),
        Row(
          children: const [
            Icon(
              Icons.live_tv_rounded,
              color: Colors.white,
              size: 20,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 12,
              ),
              child: Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
