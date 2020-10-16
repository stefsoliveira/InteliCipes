import 'package:flutter/material.dart';

final Helper = _Helper();

class _Helper {

  Size getScreenSize(BuildContext context) {
    return MediaQuery
        .of(context)
        .size;
  }

  double getScreenHeight(BuildContext context) {
    return getScreenSize(context).height;
  }

  double getScreenWidth(BuildContext context) {
    return getScreenSize(context).width;
  }

  void go(context, routeName, {arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }
  void goReplace(context, routeName, {arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  void back(context) {
    Navigator.pop(context);
  }

  void exit(context) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/', (Route<dynamic> route) => false);
  }

  Object getRouteArgs(context) {
    return ModalRoute
        .of(context)
        .settings
        .arguments;
  }

}