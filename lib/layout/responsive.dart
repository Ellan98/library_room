import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
  final Widget mobile;
  final Widget table;
  final Widget? desktop;

  const ResponsiveScreen(
      {super.key, required this.mobile, required this.table, this.desktop});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width >= 992) {
      print("desktop");
      return desktop!;
    } else if (size.width >= 576 && table != null) {

      return table!;
    } else {
      print("mobile");
      return mobile;
    }
  }
}
