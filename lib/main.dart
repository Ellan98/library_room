import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './ui/page/app/app.dart';


void main() {


  // 提前初始化 WidgetsBinding
  WidgetsFlutterBinding.ensureInitialized();

  // 监听生命周期事件
  SystemChannels.lifecycle.setMessageHandler((String? message) async {
    print('Lifecycle event: $message');
    return null;
  });

  runApp( App());

}
