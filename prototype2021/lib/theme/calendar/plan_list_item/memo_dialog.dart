import 'package:flutter/material.dart';

mixin PlanListItemMemoDialogMixin {
  Future<void> displayMemoInputDialog(
      BuildContext context,
      TextEditingController controller,
      void Function(String) setText,
      void Function() createMemo) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('메모 만들기'),
            content: TextField(
              onChanged: setText,
              controller: controller,
              decoration: InputDecoration(hintText: "메모를 작성해주세요!"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('취소'),
                onPressed: () {
                  setText("");
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text('만들기'),
                onPressed: () {
                  createMemo();
                  setText("");
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
