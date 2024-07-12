/*
 * @Date: 2024-07-10 11:00:11
 * @LastEditTime: 2024-07-12 16:16:00
 * @FilePath: \library_room\lib\model\ai\gemini_1.5-flash.dart
 * @description: 注释
 */

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

class GeminiModel extends ChangeNotifier {
  final String _model = 'gemini-1.5-pro';
  final String _apiKey = 'AIzaSyAniWlvp8fsdAuBGmCG3TMWj2ASW7nkcoI';
  bool _load = false;
  late GenerativeModel gemini;
  String _requestText = '';
  GenerateContentResponse? _responseText;

  String responseText = '';

  bool get load => _load;
  String get geminiRequest => _requestText;
  get geminiResponse => _responseText;

  late ChatSession chat;
  void loadModel() {
    gemini = GenerativeModel(
        model: _model,
        apiKey: _apiKey,
        generationConfig: GenerationConfig(
          responseMimeType: "application/json",
        ));
    _load = true;

    chat = gemini.startChat(history: [
      Content.model([TextPart('很高兴见到你。你想知道什么？')])
    ]);
  }

  questionAnswer(String question) async {
    _requestText = question;
    final content = Content.text(_requestText);
    //  根据需要设置合适的值
    _responseText = await chat.sendMessage(content);
    responseText = _responseText!.text.toString();
    notifyListeners(); // 通知监听器状态已更新     导致与之关联的 Consumer 或 Provider 的 builder 方法重新执行
  }
}
