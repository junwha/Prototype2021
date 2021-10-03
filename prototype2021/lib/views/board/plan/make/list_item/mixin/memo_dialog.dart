import 'package:flutter/material.dart';
import 'package:prototype2021/widgets/dialogs/pop_up.dart';

mixin PlanListItemMemoDialogMixin {
  Future<void> displayMemoInputDialog(
      BuildContext context,
      TextEditingController controller,
      void Function(String) setText,
      void Function() createMemo) async {
    return showDialog(
        context: context,
        builder: (context) {
          return TBSimpleDialog(
            title: '메모 만들기',
            body: TextField(
              onChanged: setText,
              controller: controller,
              decoration: InputDecoration(hintText: "메모를 작성해주세요!"),
            ),
            onBackPressed: () {
              setText("");
            },
            onSubmitPressed: () {
              createMemo();
              setText("");
            },
          );
        });
  }
}
