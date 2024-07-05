import 'package:flutter/material.dart';
import 'package:library_room/constant/images.dart';
import './widgets/chat.dart';

class SplashTable extends StatefulWidget {
  const SplashTable({super.key});

  @override
  State<SplashTable> createState() => _SplashTableState();
}

class _SplashTableState extends State<SplashTable> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;

  static const List<Widget> _widgetOptions = <Widget>[
    ChatTableLayout(),
    ChatTableLayout(),
    ChatTableLayout(),
  ];

  Widget _ScrollView(selectedPage) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
            floating: false,
            snap: false,
            pinned: true,
            backgroundColor: const Color.fromRGBO(45, 183, 245, 1),
            shadowColor: Colors.black.withOpacity(0.6),
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Drawer"),
              background: Image.asset(navigator),
            )),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
            child: Center(
              child: Text("Scroll to see the SliverAppBar in effect."),
            ),
          ),
        ),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // border: Border.all(color: Colors.blue, width: 1),
                  // color: Colors.white
                  // color: Colors.amber
                ),
                width: 220,
                height: 50,
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }, childCount: 20)),
       
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String selectedPage = '';
    return Scaffold(
        body: Row(children: <Widget>[
      SizedBox(
        width: 72,
        child: ColoredBox(
          color: const Color.fromRGBO(227, 229, 232, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: AssetImage(login), // Use AssetImage
                          fit: BoxFit.cover,
                        )
                        // shape: BoxShape()
                        ),
                  ),
                ),
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              const SizedBox(
                width: 50,
                height: 2,
                child: ColoredBox(
                  color: Color.fromRGBO(204, 206, 211, 1),
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 11, right: 11),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: AssetImage(one), // Use AssetImage
                          fit: BoxFit.cover,
                        )
                        // shape: BoxShape()
                        ),
                  ),
                ),
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(left: 11, top: 10, right: 11),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: AssetImage(two), // Use AssetImage
                          fit: BoxFit.cover,
                        )
                        // shape: BoxShape()
                        ),
                    // child:,
                  ),
                ),
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        width: 240,
        height: size.height,
        child: ColoredBox(
          color: const Color.fromRGBO(242, 243, 245, 1),
          child: _ScrollView(selectedPage),
        ),
      ),
      //      内容

      Expanded(child: _widgetOptions[_selectedIndex])
      // const VerticalDivider(thickness: 1, width: 1),
      // This is the main content.
    ]));
  }
}
