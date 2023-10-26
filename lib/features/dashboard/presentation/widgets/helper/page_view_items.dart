import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageViewItems{

  static List<Widget> pageView = [
    Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      width: 0.9.sw,
      height: 0.2.sh,
      child: const Text('Album'),
    ),
    Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      width: 0.9.sw,
      height: 0.2.sh,
      child: const Text('Favourite'),
    ),
  ];


}