import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';

void tbShowDialog(BuildContext context, Widget dialog) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return dialog;
      });
}

class TBSimpleDialog extends StatefulWidget {
  String title;
  Widget body;
  bool isBackEnabled;
  String backButtonText;
  String submitButtonText;
  Function()? onSubmitPressed;

  TBSimpleDialog({
    required this.title,
    required this.body,
    this.isBackEnabled = true,
    this.backButtonText = "취소",
    this.submitButtonText = "확인",
    this.onSubmitPressed,
  });

  @override
  _TBSimpleDialogState createState() => _TBSimpleDialogState();
}

class _TBSimpleDialogState extends State<TBSimpleDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      backgroundColor: Colors.white,
      children: [
        Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          height: 50,
          child: Text(
            this.widget.title,
            style: TextStyle(
              color: Color(0xbf707070),
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.grey,
        ),
        Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          child: this.widget.body,
        ),
        // Container(
        //   height: 1,
        //   width: double.infinity,
        //   color: Colors.grey,
        // ),
        Row(
          children: this.widget.isBackEnabled
              ? [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(double.infinity, 45),
                        shape: BeveledRectangleBorder(),
                      ),
                      child: Text(
                        this.widget.backButtonText,
                        style: TextStyle(
                          color: Color(0xbf707070),
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  buildSubmitButton(context),
                ]
              : [
                  buildSubmitButton(context),
                ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        )
      ],
    );
  }

  Expanded buildSubmitButton(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          fixedSize: Size(double.infinity, 45),
          shape: BeveledRectangleBorder(),
        ),
        child: Text(
          this.widget.submitButtonText,
          style: TextStyle(
            color: Color(0xbf707070),
            fontSize: 13,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
        onPressed: () {
          if (this.widget.onSubmitPressed != null) {
            this.widget.onSubmitPressed!.call();
          }
          Navigator.pop(context);
        },
      ),
    );
  }
}

class TBLargeDialog extends StatefulWidget {
  String title;
  Widget body;
  bool isBackEnabled;
  String backButtonText;
  String submitButtonText;
  Function()? onSubmitPressed;
  EdgeInsets padding;
  EdgeInsets insetsPadding;

  TBLargeDialog({
    required this.title,
    required this.body,
    this.isBackEnabled = true,
    this.backButtonText = "취소",
    this.submitButtonText = "확인",
    this.onSubmitPressed,
    this.padding = const EdgeInsets.all(15),
    this.insetsPadding = const EdgeInsets.all(35),
  });

  @override
  _TBLargeDialogState createState() => _TBLargeDialogState();
}

class _TBLargeDialogState extends State<TBLargeDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: this.widget.insetsPadding,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: this.widget.padding,
              alignment: Alignment.center,
              child: this.widget.body,
            ),
            Container(
              color: Colors.grey,
              child: Row(
                children: this.widget.isBackEnabled
                    ? [
                        buildButton(
                          this.widget.backButtonText,
                          Color(0xff5890ff),
                          () {
                            Navigator.pop(context);
                          },
                        ),
                        buildButton(
                          this.widget.submitButtonText,
                          Color(0xff4080ff),
                          () {
                            if (this.widget.onSubmitPressed != null) {
                              this.widget.onSubmitPressed!.call();
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ]
                    : [
                        buildButton(
                          this.widget.submitButtonText,
                          Color(0xff4080ff),
                          () {
                            if (this.widget.onSubmitPressed != null) {
                              this.widget.onSubmitPressed!.call();
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ],
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
            )
          ],
        ),
      ),
    );
  }

  Expanded buildButton(String text, Color color, Function() onPressed) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          fixedSize: Size(double.infinity, 50 * pt),
          shape: BeveledRectangleBorder(),
          backgroundColor: color,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
