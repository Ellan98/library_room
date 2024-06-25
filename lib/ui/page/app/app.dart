import 'package:flutter/material.dart';
import 'package:library_room/layout/responsive.dart';
import './table/app_table.dart';

class App extends StatelessWidget {
  const App({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResponsiveScreen(
          mobile: const AppTableView(), table: const AppTableView()),
    );
  }
}
