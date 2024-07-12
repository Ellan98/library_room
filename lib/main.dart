/*
 * @Date: 2024-06-24 15:14:50
 * @LastEditTime: 2024-07-10 11:52:34
 * @FilePath: \library_room\lib\main.dart
 * @description: 注释
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_room/ui/table/table.dart';
import './layout/responsive.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:io';
import 'package:flutter_config/flutter_config.dart';
import 'package:provider/provider.dart';
import 'package:library_room/model/ai/gemini_1.5-flash.dart';
// import './ui/page/app/app.dart';

void main() {
  // // 提前初始化 WidgetsBinding
  // WidgetsFlutterBinding.ensureInitialized();

  // // 监听生命周期事件
  // SystemChannels.lifecycle.setMessageHandler((String? message) async {
  //   print('Lifecycle event: $message');
  //   return null;
  // });

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<GeminiModel>(create: (_) => GeminiModel()),
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveScreen(
          mobile: TableLayout(), table: TableLayout(), desktop: TableLayout()),
    );
  }
}
