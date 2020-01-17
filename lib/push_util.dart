import 'package:flutter/material.dart';

class PushUtil {

  static BuildContext context;
  static Route route;

  static saveContext(BuildContext buildContext){
    context = buildContext;
  }

  static push(Widget page,BuildContext context) {
    Navigator.push(context, pageRoute(page));
    route = pageRoute(page);
  }

  static pop(BuildContext context){
    // Navigator.removeRoute(context, route);
    Navigator.of(context).pop();
  }

  static pushNamed(String routeName){
    Navigator.pushNamed(context, routeName);
  }


  static pushAndRemoveUntil(Widget page){
    Navigator.pushAndRemoveUntil(context, pageRoute(page), predicate());
  }

  static pushNamedAndRemoveUntil(String newRouteName){
    Navigator.pushNamedAndRemoveUntil(context, newRouteName, predicate());
  }

  static pushReplacement(String newRouteName,Widget page){
    Navigator.pushReplacement(context, pageRoute(page));
  }

  static pushReplacementNamed(String newRouteName){
    Navigator.pushReplacementNamed(context, newRouteName);
  }

  static popAndPushNamed(String newRouteName){
    Navigator.popAndPushNamed(context, newRouteName);
  }

  static popUntil(BuildContext context){
    Navigator.popUntil(context, predicate());
  }

  static maybePop(){
    Navigator.maybePop(context);
  }

  static predicate(){
      return (Route<dynamic> route) => false;
  }

  static pageRoute(page){
    return MaterialPageRoute(builder: (BuildContext context) {
      return page;
    });
  }
}
