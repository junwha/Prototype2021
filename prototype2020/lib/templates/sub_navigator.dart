import 'package:flutter/material.dart';

class SubNavigator extends StatefulWidget {
  final Map<String, Widget> routeMap;
  //DON'T UPDATE Global key: it occures Multiple widget used the same GlobalKey
  final Function getKey;

  SubNavigator({@required this.routeMap, @required this.getKey});

  @override
  _SubNavigatorState createState() =>
      _SubNavigatorState(routeMap: this.routeMap, getKey: this.getKey);
}

class _SubNavigatorState extends State<SubNavigator> {
  Map<String, Widget> routeMap;
  Function getKey;

  _SubNavigatorState({this.routeMap, this.getKey});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: this.getKey(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            print(settings.name);
            return routeMap[settings.name];
          },
        );
      },
    );
  }
}
