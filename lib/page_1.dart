import 'package:flutter/material.dart';
import 'package:white_board/TTabView/t_tab_main.dart';
import 'package:white_board/push_util.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page_1'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: TTabBarMainView(),
      ),
    );
  }
}