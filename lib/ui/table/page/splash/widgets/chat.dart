import 'package:flutter/material.dart';

class ChatTableLayout extends StatefulWidget {
  const ChatTableLayout({super.key});

  @override
  State<ChatTableLayout> createState() => _ChatTableLayoutState();
}

class _ChatTableLayoutState extends State<ChatTableLayout> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: ColoredBox(
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            // decoration:
            //     BoxDecoration(border: Border.all(color: Colors.red, width: 2)),
            child: _buildStack(size),
          ),
        ),
      ),
    );
  }

  Widget _buildStack(Size size) {
    return Stack(
      children: [
        const Row(
          children: [Text("1")],
        ),
        Positioned(
            bottom: 10,
            left: 5,
            right: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: size.width,
                height: 124,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(227, 229, 232, 1),
                        width: 1),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(242, 243, 245, 1),
                          offset: Offset.zero),
                      BoxShadow(
                        color: Color.fromRGBO(242, 243, 245, 1),
                        offset: Offset(-5, -5),
                        blurRadius: 10,
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: size.width,
                      child: const ColoredBox(color: Colors.grey),
                    ),
                    SizedBox(
                      width: size.width,
                      height: 80,
                      child: const ColoredBox(color: Colors.red),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
