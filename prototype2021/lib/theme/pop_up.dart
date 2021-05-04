import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';

class PopButton extends StatefulWidget {
  String buttonTitle;
  ListBody listBody;

  PopButton({required this.buttonTitle, required this.listBody});
  @override
  _PopButtonState createState() => _PopButtonState();
}

class _PopButtonState extends State<PopButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.grey, // background
        onPrimary: Colors.black, // foreground
      ),
      onPressed: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Column(
                  children: [
                    Text(
                      this.widget.buttonTitle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  ],
                ),
                content: SingleChildScrollView(child: this.widget.listBody),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 45.5 * pt,
                        width: 60 * pt,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              '취소',
                              style: TextStyle(fontSize: 13 * pt),
                            )),
                      ),
                      Container(
                        height: 45.5 * pt,
                        width: 60 * pt,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              '확인',
                              style: TextStyle(fontSize: 13 * pt),
                            )),
                      ),
                    ],
                  )
                ],
              );
            });
      },
      child: Text(this.widget.buttonTitle,
          style: TextStyle(fontSize: 13 * pt, fontWeight: FontWeight.bold)),
    );
  }
}
