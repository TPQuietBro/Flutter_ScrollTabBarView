import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:white_board/TTabView/t_tabbar.dart';
import 'package:white_board/TTabView/t_tabview.dart';

enum ScrollDirection{
  left,
  right
}

class TTabBarController {
  int index = 0;
}

class TTabBarMainView extends StatefulWidget {
  @override
  TTabBarMainViewState createState() => TTabBarMainViewState();
}

class TTabBarMainViewState extends State<TTabBarMainView> {

  PageController _pageController;

  int currentPage = 0;
  double leftScale = 1.5;
  double rightScale = 1;

  ScrollDirection scrollDirection;

  Color highlightColor = Colors.red;

  double lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(onListenPageScroll);
    this.scrollDirection = ScrollDirection.right;
  }

  onListenPageScroll(){
    double width = MediaQueryData.fromWindow(window).size.width;
    double offset = _pageController.offset;
    if (offset <= 0 || offset >= width) return;
    if (this.lastOffset <= offset) {
      this.scrollDirection = ScrollDirection.right;
      this.rightScale = 1;
      this.rightScale = 1 + 0.5 * offset / width;
      this.leftScale = 1.5 -  0.5 * offset / width;
    } else {
      this.scrollDirection = ScrollDirection.left;
      this.leftScale = 1;
      this.leftScale = 1 + 0.5 * (width - offset) / width;
      this.rightScale = 1.5 - 0.5 * (width - offset) / width;
    }

    this.lastOffset = offset;
    setState(() {
    });
    print('leftScale : $leftScale rightScale : $rightScale');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height - kToolbarHeight,
      // width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          // TTabBar(),
          // TTabBarView()
          header(),
          content()
        ],
      ),
    );
  }

  Widget header(){
    return Row(
      children: titles(),
    );
  }

  Widget content(){
    return Container(
      height: MediaQuery.of(context).size.height - kToolbarHeight - 50,
      width: MediaQuery.of(context).size.width,
      child: PageView.builder(
        itemBuilder: (BuildContext context,int index){
          return index == 0 ? views().first : views().last;
        },
        itemCount: 2,
        controller: _pageController,
        onPageChanged: (int index){
          setState(() {
            this.currentPage = index;
          });
        },
      )
    );
  }

  List<Widget> titles(){
    List<Widget> list = [];
    GestureDetector text1 = GestureDetector(
      child: Container(
        height: 30,
        width: 70,
        alignment: Alignment.center,
        child: Transform.scale(
          scale: this.leftScale > 1 ? this.leftScale : 1,
          child: Text('title1',style: TextStyle(
            color: this.currentPage == 0 ? this.highlightColor : Colors.black,
            fontSize: 13.0
          ),)
        ),
      ),
      onTap: (){
        onSelect(0);
      },
    );
    GestureDetector text2 = GestureDetector(
      child: Container(
        height: 30,
        width: 70,
        alignment: Alignment.center,
        child: Transform.scale(
          scale: this.rightScale > 1 ? this.rightScale : 1, 
          child:Text('title2',style: TextStyle(
            color: this.currentPage == 1 ? this.highlightColor : Colors.black,
            fontSize: 13.0
        ))),
      ),
      onTap: (){
        onSelect(1);
      },
    );
    list.add(text1);
    list.add(text2);
    return list;
  }

  List<Widget> views(){
    List<Widget> list = [];
    Container text1 = Container(
      height: MediaQuery.of(context).size.height - kToolbarHeight,
      width: MediaQuery.of(context).size.width,
      color: Colors.orange,
    );
    Container text2 = Container(
      height: MediaQuery.of(context).size.height - kToolbarHeight,
      width: MediaQuery.of(context).size.width,
      color: Colors.brown,
    );
    list.add(text1);
    list.add(text2);
    return list;
  }

  void onSelect(int index){
    if (_pageController.hasClients && index != _pageController.page) {
      _pageController.animateToPage(index,duration: Duration(milliseconds: 150),curve: Curves.linear);
    }
  }
}
