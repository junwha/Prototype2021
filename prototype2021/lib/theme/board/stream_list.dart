import 'package:flutter/material.dart';
import 'package:prototype2021/theme/board/board_list_view.dart';
import 'package:prototype2021/theme/loading.dart';

mixin BoardMainViewStreamListMixin {
  StreamBuilder buildStreamListView<T>(BuildContext context,
      {required Stream<List<T>> stream,
      required Widget Function(T) builder,
      Widget Function(BuildContext)? routeBuilder}) {
    return StreamBuilder<List<T>>(
      stream: stream,
      builder: (_, snapshot) {
        if (snapshot.data == null) {
          return LoadingIndicator();
        } else {
          return BoardListView<T>(
              data: snapshot.data!,
              builder: builder,
              routeBuilder: routeBuilder);
        }
      },
    );
  }
}
