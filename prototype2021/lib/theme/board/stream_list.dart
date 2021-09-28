import 'package:flutter/material.dart';
import 'package:prototype2021/theme/board/board_list_view.dart';
import 'package:prototype2021/theme/loading.dart';

class BoardMainViewStreamList<T> extends StatelessWidget {
  final Stream<List<T>> stream;
  final Widget Function(T) builder;
  final Widget Function(BuildContext, int?)? routeBuilder;
  final int refetchCount;
  final Widget? header;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final void Function()? refetch;
  final void Function(T)? onTap;

  BoardMainViewStreamList({
    required this.stream,
    required this.builder,
    this.routeBuilder,
    this.header,
    this.emptyWidget,
    this.errorWidget,
    this.refetch,
    this.refetchCount = 3,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => buildStreamListView(context);

  StreamBuilder buildStreamListView(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: stream,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          if (refetch != null) {
            refetch!();
          }
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
