import 'package:flutter/material.dart';
import 'package:library_room/widgets/dash_animation.dart';

class AppTableView extends StatelessWidget {
  const AppTableView({super.key});

  Widget build(BuildContext context) {
    Dash dash = Dash();
    return  Scaffold(
      body: SizedBox(
        width: 200,
        height: 200,
        child: dash.idle(),
      ),
    );
  }
}
