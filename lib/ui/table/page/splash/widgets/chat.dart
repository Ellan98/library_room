/*
 * @Date: 2024-07-05 16:21:51
 * @LastEditTime: 2024-07-12 17:13:54
 * @FilePath: \library_room\lib\ui\table\page\splash\widgets\chat.dart
 * @description: 注释
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:library_room/model/ai/gemini_1.5-flash.dart';
import 'package:library_room/constant/images.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:math';
import 'package:library_room/common/utils/conver.dart';
import 'package:library_room/http/request.dart';

class ChatTableLayout extends StatefulWidget {
  const ChatTableLayout({super.key});

  @override
  State<ChatTableLayout> createState() => _ChatTableLayoutState();
}

class _ChatTableLayoutState extends State<ChatTableLayout> {
  String request = '';
  int index = 0;

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController(); //listview的控制器

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      print('Current value: ${_controller.text}');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // 使用 context.watch 获取 GeminiModel 实例，并监听数据变化
    GeminiModel gemini = context.watch<GeminiModel>();

    // return Consumer<GeminiModel>(
    //   builder: (context, gemini, child) {
    //     gemini.loadModel();
    //    // 返回 ChatTableLayout 或其他需要的 Widget
    //   },
    // );

    return Scaffold(
        appBar: _appBar(),
        body: ColoredBox(
          color: const Color.fromRGBO(255, 255, 255, 1),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: ColoredBox(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  child: Container(
                    //列表内容少的时候靠上
                    alignment: Alignment.topCenter,
                    child: _renderHistoryList(),
                  ),
                ),
              ),
              // 输入框
              Container(
                  width: size.width,
                  constraints:
                      const BoxConstraints(maxHeight: 150, minHeight: 50),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(227, 229, 232, 1),
                        width: 1),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                          constraints: const BoxConstraints(
                            maxHeight: 100.0,
                            minHeight: 50.0,
                          ),
                          decoration: const BoxDecoration(
                              color: Color(0xFFF5F6FF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                          child: TextField(
                            controller: _controller,
                            cursorColor: const Color.fromRGBO(227, 229, 232, 1),
                            maxLines: null,
                            maxLength: 500,
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 10.0,
                                  bottom: 10.0),
                              hintText: "Please enter your question",
                              hintStyle: TextStyle(
                                  color: Color(0xFFADB3BA), fontSize: 15),
                            ),
                            style: const TextStyle(
                                color: Color(0xFF03073C), fontSize: 15),
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          alignment: Alignment.center,
                          height: 70,
                          child: const Text(
                            '发送',
                            style: TextStyle(
                              color: Color(0xFF464EB5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        onTap: () async {
                          await dio.get('/test');
                          sendTxt();

                          await gemini.questionAnswer(_controller.text);
                          responseText(gemini.responseText);
                          setState(() {
                            _controller.text = '';
                          });
                        },
                      )
                    ],
                  )),
            ],
          ),
        ));
  }

  AppBar _appBar() {
    return AppBar(title: const Text('Gemini'), actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.settings),
        tooltip: 'Show Snackbar',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('This is a snackbar')));
        },
      ),
      IconButton(
          icon: const Icon(Icons.navigate_next),
          tooltip: 'Go to the next page',
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute<void>(
            //   builder: (BuildContext context) {
            //     return Scaffold(
            //       appBar: AppBar(
            //         title: const Text('Next page'),
            //       ),
            //       body: const Center(
            //         child: Text(
            //           'This is the next page',
            //           style: TextStyle(fontSize: 24),
            //         ),
            //       ),
            //     );
            //   },
            // );
          })
    ]);
  }

  // 聊天列表
  List historyList = [];

  Widget _renderHistoryList() {
    return GestureDetector(
      child: ListView.builder(
        reverse: true,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 27),
        itemBuilder: (context, index) {
          var item = historyList[index];

          return GestureDetector(
            child: item['employeeNo'] == 'emloyeeNo'
                ? _renderRowSendByMe(context, item)
                : _renderRowSendByOthers(context, item),
            onTap: () {},
          );
        },
        itemCount: historyList.length,
        controller: _scrollController,
      ),
    );
  }

  Widget _renderRowSendByMe(BuildContext context, item) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              // 时间转换
              timeStampFormat(item['createdAt']),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFA1A6BB),
                fontSize: 14,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                alignment: Alignment.center,
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                    color: Color(0xFF464EB5),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    item['name'].toString().substring(0, 1),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      item['name'],
                      softWrap: true,
                      style: const TextStyle(
                        color: Color(0xFF677092),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 16, 2, 0),
                        // child: Image(
                        //   width: 11,
                        //   height: 20,
                        //   image: AssetImage(login), // Use AssetImage
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 400,
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(top: 8, right: 10),
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(4.0, 7.0),
                                      color: Color(0x04000000),
                                      blurRadius: 10,
                                    ),
                                  ],
                                  color: Color.fromRGBO(51, 204, 102, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                item['reply'],
                                softWrap: true,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                              child: item['status'] == SENDING_TYPE
                                  ? ConstrainedBox(
                                      constraints: const BoxConstraints(
                                          maxWidth: 10, maxHeight: 10),
                                      child: const SizedBox(
                                        width: 10,
                                        height: 10,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.grey),
                                        ),
                                      ),
                                    )
                                  : item['status'] == FAILED_TYPE
                                      ? Image(
                                          width: 11,
                                          height: 20,
                                          image: AssetImage(login))
                                      : Container()),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _renderRowSendByOthers(BuildContext context, item) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              timeStampFormat(item['createdAt']),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFA1A6BB),
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 45),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                      color: Color(0xFF464EB5),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      item['name'].toString().substring(0, 1),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 30),
                        child: Text(
                          item['name'],
                          softWrap: true,
                          style: const TextStyle(
                            color: Color(0xFF677092),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.fromLTRB(2, 16, 0, 0),
                            // child: const Image(
                            //     width: 11,
                            //     height: 20,
                            //     image: AssetImage(
                            //         "static/images/chat_white_arrow.png")),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(4.0, 7.0),
                                    color: Color(0x04000000),
                                    blurRadius: 10,
                                  ),
                                ],
                                color: Color.fromRGBO(242, 243, 245, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            margin: const EdgeInsets.only(top: 8, left: 10),
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              item['reply'],
                              style: const TextStyle(
                                color: Color(0xFF03073C),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int maxValue = 1 << 32 - 1;

  sendTxt() {
    int tag = random.nextInt(maxValue) + 1;

    String message = _controller.text;
    addMessage(message, tag);

    setState(() {
      historyList[index]['status'] = SUCCESSED_TYPE;
    });
  }

  final random = Random();
  responseText(String text) {
    int time = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      historyList.insert(0, {
        "createdAt": time,
        "cusUid": "Gemini",
        "employeeNo": "Gemini",
        "name": "Gemini",
        // "orderNo": widget.orderNo,
        "reply": text,
        "updatedAt": time,
        'status': SENDING_TYPE,
        'tag': random.nextInt(maxValue) + 1,
      });
    });
    Timer(const Duration(milliseconds: 100), () => _scrollController.jumpTo(0));
  }

  addMessage(content, tag, {info}) {
    int time = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      historyList.insert(0, {
        "createdAt": time,
        "cusUid": "Ellan",
        "employeeNo": "emloyeeNo",
        "name": "Ellan",
        // "orderNo": widget.orderNo,
        "reply": content,
        "updatedAt": time,
        'status': SENDING_TYPE,
        'tag': '$tag',
      });

      print(historyList);
    });
    Timer(const Duration(milliseconds: 100), () => _scrollController.jumpTo(0));
  }

  static int SENDING_TYPE = 0;
  static int FAILED_TYPE = 1;
  static int SUCCESSED_TYPE = 2;
}
