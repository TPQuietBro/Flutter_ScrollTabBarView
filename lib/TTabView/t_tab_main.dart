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

class TTabBarMainViewState extends State<TTabBarMainView> with SingleTickerProviderStateMixin{

  PageController _pageController;

  int currentPage = 0;
  double leftScale = 1.5;
  double rightScale = 1;
  double colorValue = 0;

  ScrollDirection scrollDirection;

  Color highlightColor = Colors.red;

  double lastOffset = 0;

  List list = ['title1','title2'];


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
      this.colorValue = offset / width;
    } else {
      this.scrollDirection = ScrollDirection.left;
      this.leftScale = 1;
      this.leftScale = 1 + 0.5 * (width - offset) / width;
      this.rightScale = 1.5 - 0.5 * (width - offset) / width;
      this.colorValue = offset / width;
    }

    this.lastOffset = offset;
    setState(() {
    });
    print('leftScale : $leftScale rightScale : $rightScale');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          return views(index);
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
    
    List<Widget> widgets = [];
    List scales = [this.leftScale,this.rightScale];
    List colors = [titleColor(this.colorValue, ScrollDirection.left),titleColor(this.colorValue, ScrollDirection.right)];
    
    for (var i = 0; i < list.length; i++) {
      String titleS = list[i];
      widgets.add(title(titleS, i,scales[i], this.currentPage,colors[i]));
    }
    
    return widgets;
  }

  Color titleColor(double value,ScrollDirection scrollDirection){
    Color red = Colors.red;
    Color black = Colors.black;

    return scrollDirection == ScrollDirection.left ? Color.lerp(red, black, value) : Color.lerp(black, red, value);
  }

  Widget title(String title,int index,double scale,int page,Color color){

    return GestureDetector(
      child: Container(
        height: 30,
        width: 70,
        alignment: Alignment.center,
        child: Transform.scale(
          scale: scale > 1 ? scale : 1, 
          child: Text(title,style: TextStyle(
                  color: color,//page == 1 ? this.highlightColor : Colors.black,
                  fontSize: 13.0
              ))
          ),
      ),
      onTap: (){
        onSelect(index);
      },
    );
  }

  Widget views(int index){
    List<Widget> widgets = [];
    List colors = [Colors.orange,Colors.brown];
    for (var i = 0; i < this.list.length; i++) {
      widgets.add(view(colors[i]));
    }
    return widgets[index];
  }

  view (Color color){
    return Container(
      height: MediaQuery.of(context).size.height - kToolbarHeight,
      width: MediaQuery.of(context).size.width,
      color: color,
    );
  }

  void onSelect(int index){
    if (_pageController.hasClients && index != _pageController.page) {
      _pageController.animateToPage(index,duration: Duration(milliseconds: 150),curve: Curves.linear);
    }
  }
}
