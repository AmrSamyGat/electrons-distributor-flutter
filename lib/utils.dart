import 'package:flutter/material.dart';

double widthRatio(BuildContext context, double percentage) {
  // from 0 to 1
  return MediaQuery.of(context).size.width * percentage;
}

double heightRatio(BuildContext context, double percentage) {
  // from 0 to 1
  return MediaQuery.of(context).size.height * percentage;
}

double heightNoSafeAreaRatio(BuildContext context, double percentage) {
  // from 0 to 1
  var padding = MediaQuery.of(context).padding;
  double height = MediaQuery.of(context).size.height;
  double height1 = height - padding.top - padding.bottom;
  return height1 * percentage;
}
