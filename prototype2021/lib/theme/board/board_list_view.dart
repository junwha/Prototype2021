import 'package:flutter/material.dart';

class BoardListView<T> extends StatelessWidget {
  final List<T> data;
  final Widget Function(T) builder;
  final void Function(T)? onTap;
  final Widget Function(BuildContext)? routeBuilder;
  final Widget? header;

  const BoardListView({
    Key? key,
    required this.data,
    required this.builder,
    this.onTap,
    this.routeBuilder,
    this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* 
     * If routeBuilder is provided and not onTap, 
     * it'll push the route with routeBuilder
     * If onTap is provided, it'll override routeBuilder, 
     * not navigating to the route
     */
    void _onTap(T datum) {
      if (onTap != null) {
        onTap!(datum);
        return;
      }
      if (routeBuilder != null) {
        Navigator.push(context, MaterialPageRoute(builder: routeBuilder!));
        return;
      }
    }

    List<Widget> _children = data
        .map<Widget>((datum) => GestureDetector(
              onTap: () => _onTap(datum),
              child: builder(datum),
            ))
        .toList();

    // Idk why this error occurs,
    // but anyway, I need to set all widgets in _children
    // as GestureDetector
    if (header != null) {
      _children.insert(0, header!);
    }

    return SingleChildScrollView(
      child: Column(children: _children),
    );
  }
}
