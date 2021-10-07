import 'package:flutter/material.dart';
import 'package:prototype2021/views/board/base/mixin/board_list_view.dart';
import 'package:prototype2021/widgets/notices/loading.dart';

class BoardStreamList<T> extends StatelessWidget {
  final Stream<List<T>> stream;
  final Widget Function(T) builder;
  final Widget Function(BuildContext, int?)? routeBuilder;
  final Widget? header;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final void Function(T)? onTap;

  BoardStreamList({
    required this.stream,
    required this.builder,
    this.routeBuilder,
    this.header,
    this.emptyWidget,
    this.errorWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => buildStreamListView(context);

  StreamBuilder buildStreamListView(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: stream,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndicator();
        }
        if (snapshot.hasData) {
          if (snapshot.data!.length > 0) {
            return BoardListView<T>(
              header: header,
              data: snapshot.data!,
              builder: builder,
              routeBuilder: routeBuilder,
              onTap: onTap,
            );
          } else {
            return emptyWidget ?? SizedBox();
          }
        }
        return errorWidget ?? SizedBox();
      },
    );
  }
}
