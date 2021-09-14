import 'package:flutter/material.dart';

class BoardListView<T> extends StatelessWidget {
  final List<T> data;
  final Widget Function(T) builder;
  final void Function(T)? onTap;
  const BoardListView({
    Key? key,
    required this.data,
    required this.builder,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onTap(T datum) {
      if (onTap != null) {
        onTap!(datum);
      }
    }

    return SingleChildScrollView(
      child: Column(
          children: data
              .map((datum) => GestureDetector(
                    onTap: () => _onTap(datum),
                    child: builder(datum),
                  ))
              .toList()),
    );
  }
}
