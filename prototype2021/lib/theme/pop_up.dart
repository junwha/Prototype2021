import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';

class PopButton extends StatefulWidget {
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
                    Text('임시저장'),
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
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Container(
                        width: 291 * pt,
                        height: 250 * pt,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("임시 저장하시겠습니까?",
                                style: TextStyle(fontSize: 17 * pt)),
                            SizedBox(
                              height: 15,
                            ),
                            Text('임시 저장한 글은',
                                style: TextStyle(
                                  fontSize: 14 * pt,
                                )),
                            Text('\'내 정보 > 임시 저장한 글\'',
                                style: TextStyle(
                                    fontSize: 14 * pt,
                                    fontWeight: FontWeight.bold)),
                            Text('에서 볼 수 있어요.',
                                style: TextStyle(fontSize: 14 * pt))
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
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
      child: Text('임시저장',
          style: TextStyle(fontSize: 13 * pt, fontWeight: FontWeight.bold)),
    );
  }
}
