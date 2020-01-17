import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:white_board/page_1.dart';
import 'package:white_board/push_util.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
 
  TabController tabController;

  @override
  initState(){
    super.initState();
    tabController = TabController(initialIndex: 0,length: titles().length,vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          indicatorColor: Colors.white.withOpacity(1),
          controller: tabController,
          isScrollable: true,
          labelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          unselectedLabelColor: Color(0xff666666),
          unselectedLabelStyle: TextStyle(fontSize: 14),
          tabs: titles(),
        )
      ),
      body: Center(
        child: TabBarView(
          controller: tabController,
          children: views(),
        )
      ),
    );
  }

  List<Widget> titles(){
    List<Widget> list = [];
    Text text1 = Text('page1');
    Text text2 = Text('page2');
    list.add(text1);
    list.add(text2);
    return list;
  }

  List<Widget> views(){
    List<Widget> list = [];
    GestureDetector text1 = GestureDetector(
      child: Center(
        child: Text('view1')
      ),
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_){
            return Page1();
          }
        ));
      },
    );
    Text text2 = Text('view2');
    list.add(text1);
    list.add(text2);
    return list;
  }
}
